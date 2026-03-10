// lib/features/gamification/achievement_service.dart

import 'package:get/get.dart';
import '../../core/db/app_database.dart';
import '../../core/puzzle/models.dart';

class AchievementService extends GetxService {
  static AchievementService get to => Get.find();

  final AppDatabase _db;

  AchievementService(this._db);

  /// Analyzes the completed [result] against current [stats] to unlock new achievements.
  /// Returns a list of newly unlocked achievement IDs.
  Future<List<String>> checkAndUnlock(UserStat stats, GameResult result, {bool isDaily = false}) async {
    final newUnlocks = <String>[];
    
    // Track stats for the current puzzle
    final time = result.elapsed.inSeconds;
    final diff = result.difficulty;
    final noMistakes = result.mistakes == 0;
    final closeCall = result.mistakes == 2;
    final noHints = result.hintsUsed == 0;
    
    // Parse puzzles per difficulty
    int totalPuzzles = 0;
    try {
      final map = Map<String, int>.from(
          stats.puzzlesPerDifficulty == '{}' ? {} : (stats.puzzlesPerDifficulty as Map));
      // AppDatabase stores this map via JSON so it's a bit decoupled. We assume stats reflects pre-game totals 
      // + 1 for the game just finished (since we intend to call stats update before achievement check).
      for (final v in map.values) {
        totalPuzzles += v;
      }
    } catch (_) {}

    final nowHours = DateTime.now().hour;

    // Retrieve already unlocked achievements directly from Drift
    final unlockedRecords = await _db.achievementsDao.getUnlocked();
    final unlockedIds = unlockedRecords.map((e) => e.id).toSet();

    // Helper to evaluate and unlock
    Future<void> evaluate(String id, bool condition) async {
      if (condition && !unlockedIds.contains(id)) {
        final success = await _db.achievementsDao.unlock(id);
        if (success) {
          newUnlocks.add(id);
          unlockedIds.add(id); // prevent duplicate checks within same run
        }
      }
    }

    // Evaluate all conditions
    await evaluate('first_solve', true);
    await evaluate('first_easy', diff == Difficulty.easy);
    await evaluate('first_medium', diff == Difficulty.medium);
    await evaluate('first_hard', diff == Difficulty.hard);
    await evaluate('first_master', diff == Difficulty.master);
    await evaluate('first_extreme', diff == Difficulty.extreme);

    await evaluate('solve_10', totalPuzzles >= 10);
    await evaluate('solve_50', totalPuzzles >= 50);
    await evaluate('solve_100', totalPuzzles >= 100);
    await evaluate('solve_500', totalPuzzles >= 500);

    await evaluate('perfect_easy', diff == Difficulty.easy && noMistakes);
    await evaluate('perfect_hard', diff == Difficulty.hard && noMistakes);
    await evaluate('perfect_extreme', diff == Difficulty.extreme && noMistakes);

    await evaluate('no_hints_medium', diff == Difficulty.medium && noHints);
    await evaluate('no_hints_master', diff == Difficulty.master && noHints);

    await evaluate('speed_easy_3m', diff == Difficulty.easy && time < 180);
    await evaluate('speed_medium_5m', diff == Difficulty.medium && time < 300);
    await evaluate('speed_hard_10m', diff == Difficulty.hard && time < 600);

    if (isDaily) {
      await evaluate('first_daily', true);
    }
    
    await evaluate('streak_3', stats.streakDays >= 3);
    await evaluate('streak_7', stats.streakDays >= 7);
    await evaluate('streak_30', stats.streakDays >= 30);

    await evaluate('level_5', stats.level >= 5);
    await evaluate('level_10', stats.level >= 10);
    await evaluate('level_20', stats.level >= 20);

    await evaluate('close_call', closeCall);
    await evaluate('owl', nowHours >= 0 && nowHours <= 4);
    await evaluate('morning', nowHours >= 5 && nowHours <= 8);

    return newUnlocks;
  }
}
