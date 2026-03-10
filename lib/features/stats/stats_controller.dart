// lib/features/stats/stats_controller.dart

import 'dart:convert';
import 'package:get/get.dart';
import '../../core/db/db_service.dart';
import '../../core/puzzle/models.dart';
import '../gamification/level_service.dart';

class StatsController extends GetxController {
  final db = DbService.instance;
  
  final isLoading = true.obs;
  
  // Observables
  final level = 1.obs;
  final totalXP = 0.obs;
  final currentXP = 0.obs;
  final nextLevelXP = 1.obs;
  final progressToNext = 0.0.obs;
  final levelTitle = 'Novice'.obs;
  
  final totalMistakes = 0.obs;
  final totalHints = 0.obs;
  
  // Difficulty Breakdown
  final puzzlesPerDifficulty = <Difficulty, int>{}.obs;
  
  // Computed
  int get totalPuzzlesSolved {
    return puzzlesPerDifficulty.values.fold(0, (sum, count) => sum + count);
  }

  @override
  void onInit() {
    super.onInit();
    _loadStats();
  }

  Future<void> _loadStats() async {
    isLoading.value = true;
    try {
      final stats = await db.userStats.getStats();
      if (stats != null) {
        totalXP.value = stats.totalXP;
        level.value = LevelService.getLevel(stats.totalXP);
        levelTitle.value = LevelService.getLevelTitle(level.value);
        nextLevelXP.value = LevelService.getXPForNextLevel(level.value);
        currentXP.value = LevelService.getCurrentLevelXP(stats.totalXP);
        progressToNext.value = LevelService.getProgressToNextLevel(stats.totalXP);
        
        totalMistakes.value = stats.totalMistakes;
        totalHints.value = stats.totalHints;

        final mapStr = stats.puzzlesPerDifficulty;
        if (mapStr.isNotEmpty) {
          final Map<String, dynamic> rawMap = jsonDecode(mapStr);
          final parsed = <Difficulty, int>{};
          for (final diff in Difficulty.values) {
            parsed[diff] = (rawMap[diff.name] as num?)?.toInt() ?? 0;
          }
          puzzlesPerDifficulty.assignAll(parsed);
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}
