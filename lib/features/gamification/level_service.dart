// lib/features/gamification/level_service.dart

class LevelService {
  // Scaling XP thresholds for levels 1 through 50+
  static final List<int> _xpThresholds = [
    0,      // Level 1
    200,    // Level 2
    500,    // Level 3
    1000,   // Level 4
    1800,   // Level 5
    3000,   // Level 6
    5000,   // Level 7
    8000,   // Level 8
    12000,  // Level 9
    18000,  // Level 10
    26000,  // Level 11
    36000,  // Level 12
    50000,  // Level 13
    75000,  // Level 14
    100000, // Level 15
    150000, // Level 16
    250000, // Level 17
    400000, // Level 18
    600000, // Level 19
    1000000 // Level 20
  ];

  static int getLevel(int totalXP) {
    if (totalXP < 0) return 1;
    for (int i = 0; i < _xpThresholds.length; i++) {
        // If we exceed the highest defined threshold, calculate manually or just cap it
        if (i == _xpThresholds.length - 1) {
            final overage = totalXP - _xpThresholds.last;
            return _xpThresholds.length + (overage ~/ 500000); 
        }
        
        if (totalXP >= _xpThresholds[i] && totalXP < _xpThresholds[i + 1]) {
            return i + 1; // 1-indexed levels
        }
    }
    return 1;
  }

  static String getLevelTitle(int level) {
    if (level < 3) return 'Novice';
    if (level < 6) return 'Apprentice';
    if (level < 10) return 'Solver';
    if (level < 14) return 'Expert';
    if (level < 18) return 'Master';
    return 'Legend';
  }

  static int getXPForNextLevel(int currentLevel) {
    if (currentLevel >= _xpThresholds.length) {
      // 500k flat scaling above Level 20
      return 500000;
    }
    final currentBase = _xpThresholds[currentLevel - 1];
    final nextBase = _xpThresholds[currentLevel];
    return nextBase - currentBase;
  }

  static int getCurrentLevelXP(int totalXP) {
    final curLevel = getLevel(totalXP);
    if (curLevel >= _xpThresholds.length) {
      final overage = totalXP - _xpThresholds.last;
      return overage % 500000;
    }
    return totalXP - _xpThresholds[curLevel - 1];
  }

  static double getProgressToNextLevel(int totalXP) {
    final curLevel = getLevel(totalXP);
    
    if (curLevel >= _xpThresholds.length) {
        final overage = totalXP - _xpThresholds.last;
        final remainderInLevel = overage % 500000;
        return remainderInLevel / 500000.0;
    }

    final currentBase = _xpThresholds[curLevel - 1];
    final nextBase = _xpThresholds[curLevel];
    final xpInCurrentLevel = totalXP - currentBase;
    final xpNeeded = nextBase - currentBase;
    
    if (xpNeeded <= 0) return 1.0;
    return (xpInCurrentLevel / xpNeeded).clamp(0.0, 1.0);
  }
}
