// lib/features/gamification/xp_service.dart

import '../../core/puzzle/models.dart';

class XpService {
  static const Map<Difficulty, int> _baseXP = {
    Difficulty.easy: 50,
    Difficulty.medium: 100,
    Difficulty.hard: 200,
    Difficulty.master: 350,
    Difficulty.extreme: 600,
  };

  static const Map<Difficulty, int> _timeThresholds = {
    Difficulty.easy: 300,    // 5 mins
    Difficulty.medium: 600,  // 10 mins
    Difficulty.hard: 1200,   // 20 mins
    Difficulty.master: 2100, // 35 mins
    Difficulty.extreme: 3600,// 60 mins
  };

  static int calculateXP({
    required Difficulty difficulty,
    required int elapsedSeconds,
    required int mistakes,
    required int hintsUsed,
    required bool isDaily,
  }) {
    final base = _baseXP[difficulty] ?? 50;
    final threshold = _timeThresholds[difficulty] ?? 300;
    
    final timeBonus = elapsedSeconds < threshold ? 1.5 : 1.0;
    final noMistakesBonus = mistakes == 0 ? 1.25 : 1.0;
    final noHintsBonus = hintsUsed == 0 ? 1.15 : 1.0;
    final dailyBonus = isDaily ? 2.0 : 1.0;

    return (base * timeBonus * noMistakesBonus * noHintsBonus * dailyBonus).round();
  }
}
