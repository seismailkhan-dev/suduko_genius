// lib/features/gamification/models/achievement_def.dart

class AchievementDef {
  final String id;
  final String title;
  final String description;
  final String icon; // Icon name or asset path

  const AchievementDef({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}
