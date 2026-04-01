// lib/features/daily/daily_controller.dart

import 'dart:async';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/firebase/firestore_service.dart';

import '../../core/db/app_database.dart';
import '../../core/db/db_service.dart';
import '../../core/puzzle/models.dart';
import '../../core/puzzle/sudoku_generator.dart';

enum DayStatus { done, missed, future, today }

class DailyController extends GetxController {
  final isDoneToday = false.obs;
  final calendarData = <DateTime, DayStatus>{}.obs;
  final streakCount = 0.obs;
  final countdownString = '00:00:00'.obs;
  late final Rx<SudokuPuzzle?> todayPuzzle = Rx<SudokuPuzzle?>(null);

  Timer? _countdownTimer;

  @override
  void onInit() {
    super.onInit();
    _initDailyData();
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    super.onClose();
  }

  Future<void> _initDailyData() async {
    final now = DateTime.now();
    final todayStr = now.toIso8601String().split('T')[0];

    // 1. Check if today is done
    final db = DbService.instance;
    final todayRecord = await db.daily.getByDate(todayStr);
    isDoneToday.value = todayRecord != null;

    // 2. Build calendar for last 30 days
    final Map<DateTime, DayStatus> cal = {};
    int computedStreak = 0;
    bool streakBroken = false;

    // Iterate backwards from today to 29 days ago
    for (int i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));
      final dateStr = date.toIso8601String().split('T')[0];
      
      final record = await db.daily.getByDate(dateStr);
      final isDone = record != null;

      if (i == 0) {
        cal[date] = isDone ? DayStatus.done : DayStatus.today;
        if (isDone) computedStreak++;
      } else {
        cal[date] = isDone ? DayStatus.done : DayStatus.missed;
        
        if (isDone && !streakBroken) {
          computedStreak++;
        } else if (!isDone) {
          // If yesterday was missed, streak is 0. If earlier was missed, streak ends there.
          if (i == 1 && !isDoneToday.value) {
            // It's fine if yesterday was missed IF today is also not done yet, 
            // wait, if yesterday is missed, the active streak is definitively 0.
            streakBroken = true;
          } else if (i > 1 || (i == 1 && isDoneToday.value)) {
             streakBroken = true;
          }
        }
      }
    }

    // 3. Update observables
    calendarData.assignAll(cal);
    
    // Use the actual user stats streak as source of truth for total historical streak
    final stats = await db.userStats.getStats();
    streakCount.value = stats?.streakDays ?? computedStreak;

    // 4. Generate today's puzzle deterministically
    todayPuzzle.value = SudokuGenerator.generateForDate(todayStr);

    // 5. Start Countdown
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final tomorrow = DateTime(now.year, now.month, now.day + 1);
      final diff = tomorrow.difference(now);
      
      final h = diff.inHours.toString().padLeft(2, '0');
      final m = (diff.inMinutes % 60).toString().padLeft(2, '0');
      final s = (diff.inSeconds % 60).toString().padLeft(2, '0');
      countdownString.value = '$h:$m:$s';
    });
  }

  void startDailyChallenge() {
    if (isDoneToday.value) {
      Get.snackbar(
        'Already Completed',
        'Come back tomorrow for a new challenge!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade800,
        colorText: Colors.white,
      );
      return;
    }

    if (todayPuzzle.value != null) {
      Get.toNamed('/game', arguments: {
        'action': 'daily_puzzle',
        'puzzle': todayPuzzle.value,
        'isDaily': true,
      });
    }
  }

  Future<void> onDailyComplete(GameResult result) async {
    final now = DateTime.now();
    final todayStr = now.toIso8601String().split('T')[0];

    final db = DbService.instance;
    await db.daily.insert(
      DailyCompletionsCompanion.insert(
        date: todayStr,
        difficulty: result.difficulty.name,
        timeSeconds: result.elapsed.inSeconds,
        mistakes: drift.Value(result.mistakes),
        hintsUsed: drift.Value(result.hintsUsed),
        xpEarned: drift.Value(result.xpEarned * 2), // Daily 2x bonus
      ),
    );

    // Push to Firestore Daily Leaderboard
    try {
      if (Get.isRegistered<FirestoreService>()) {
        await Get.find<FirestoreService>().pushDailyResult(todayStr, result);
      }
    } catch (_) {}

    // Update Streak
    final stats = await db.userStats.getStats();
    final lastPlayed = stats?.lastPlayedDate ?? '';
    int newStreak = stats?.streakDays ?? 0;

    if (lastPlayed != todayStr) {
      if (lastPlayed.isNotEmpty) {
        final lastTime = DateTime.parse(lastPlayed);
        final todayTime = DateTime.parse(todayStr);
        final diffDays = todayTime.difference(lastTime).inDays;
        
        if (diffDays == 1) {
          newStreak++;
        } else if (diffDays > 1 || diffDays < 0) {
          newStreak = 1;
        }
      } else {
        newStreak = 1;
      }

      if (stats == null) {
        await db.userStats.insertStats(UserStatsCompanion(
          streakDays: drift.Value(newStreak),
          lastPlayedDate: drift.Value(todayStr),
        ));
      } else {
        await db.userStats.updateStats(stats.toCompanion(true).copyWith(
          streakDays: drift.Value(newStreak),
          lastPlayedDate: drift.Value(todayStr),
        ));
      }
    }

    // Refresh state
    await _initDailyData();
  }
}
