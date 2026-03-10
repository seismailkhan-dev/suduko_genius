// lib/features/achievements/achievements_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../app/theme/app_theme.dart';
import '../gamification/achievement_definitions.dart';
import '../gamification/models/achievement_def.dart';
import 'achievements_controller.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AchievementsController());
    final colors = Theme.of(context).extension<GameColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.boardBackground,
      appBar: AppBar(
        title: Text(
          'Achievements',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final unlockedCount = controller.unlockedIds.length;
        final totalCount = AchievementDefinitions.all.length;
        final progress = unlockedCount / totalCount;

        return Column(
          children: [
            // Progress Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Completion', style: textTheme.titleMedium),
                      Text('$unlockedCount / $totalCount',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.accent,
                          )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 12,
                      backgroundColor: colors.cellBorder,
                      valueColor: const AlwaysStoppedAnimation(AppTheme.accent),
                    ),
                  ).animate().scaleX(begin: 0, duration: 800.ms, curve: Curves.easeOut),
                ],
              ),
            ),

            // Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).copyWith(bottom: 40),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: AchievementDefinitions.all.length,
                itemBuilder: (context, index) {
                  final def = AchievementDefinitions.all[index];
                  final isUnlocked = controller.unlockedIds.contains(def.id);
                  return _AchievementBadge(
                    def: def,
                    isUnlocked: isUnlocked,
                    index: index,
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  final AchievementDef def;
  final bool isUnlocked;
  final int index;

  const _AchievementBadge({
    required this.def,
    required this.isUnlocked,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<GameColors>()!;
    
    // Simple icon mapping fallback
    final IconData iconData = _getIconData(def.icon);

    Widget badge = GestureDetector(
      onTap: () => _showDetails(context),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isUnlocked ? AppTheme.accent.withValues(alpha: 0.15) : colors.cellBorder,
                border: Border.all(
                  color: isUnlocked ? AppTheme.accent : Colors.transparent,
                  width: 2,
                ),
                boxShadow: isUnlocked
                    ? [
                        BoxShadow(
                          color: AppTheme.accent.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        )
                      ]
                    : null,
              ),
              child: Center(
                child: Icon(
                  isUnlocked ? iconData : Icons.lock,
                  color: isUnlocked ? AppTheme.accent : Colors.grey.shade500,
                  size: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            def.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 10,
              fontWeight: isUnlocked ? FontWeight.bold : FontWeight.normal,
              color: isUnlocked ? null : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );

    // Initial load animation
    return badge.animate()
        .fadeIn(delay: (index * 30).ms)
        .slideY(begin: 0.2, delay: (index * 30).ms);
  }

  void _showDetails(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).extension<GameColors>()!;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 32),
              
              // Big Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isUnlocked ? AppTheme.accent.withValues(alpha: 0.1) : colors.cellBorder,
                ),
                child: Icon(
                  isUnlocked ? _getIconData(def.icon) : Icons.lock,
                  size: 48,
                  color: isUnlocked ? AppTheme.accent : Colors.grey,
                ),
              ).animate(target: isUnlocked ? 1 : 0)
                .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack)
                .shimmer(duration: 1500.ms),
                
              const SizedBox(height: 24),
              Text(
                isUnlocked ? def.title : 'Locked',
                style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                def.description,
                style: textTheme.bodyLarge?.copyWith(
                  color: isUnlocked ? null : Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'star': return Icons.star;
      case 'child_care': return Icons.child_care;
      case 'fitness_center': return Icons.fitness_center;
      case 'engineering': return Icons.engineering;
      case 'psychology': return Icons.psychology;
      case 'local_fire_department': return Icons.local_fire_department;
      case 'filter_1': return Icons.filter_1;
      case 'filter_5': return Icons.filter_5;
      case 'workspace_premium': return Icons.workspace_premium;
      case 'diamond': return Icons.diamond;
      case 'check_circle': return Icons.check_circle;
      case 'ac_unit': return Icons.ac_unit;
      case 'gpp_good': return Icons.gpp_good;
      case 'visibility_off': return Icons.visibility_off;
      case 'school': return Icons.school;
      case 'bolt': return Icons.bolt;
      case 'timer': return Icons.timer;
      case 'rocket_launch': return Icons.rocket_launch;
      case 'today': return Icons.today;
      case 'calendar_month': return Icons.calendar_month;
      case 'hotel_class': return Icons.hotel_class;
      case 'emoji_events': return Icons.emoji_events;
      case 'military_tech': return Icons.military_tech;
      case 'trending_up': return Icons.trending_up;
      case 'warning': return Icons.warning;
      case 'brightness_3': return Icons.brightness_3;
      case 'wb_twilight': return Icons.wb_twilight;
      default: return Icons.emoji_events;
    }
  }
}
