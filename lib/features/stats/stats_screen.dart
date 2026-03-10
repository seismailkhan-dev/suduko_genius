// lib/features/stats/stats_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../app/theme/app_theme.dart';
import '../../core/puzzle/models.dart';
import 'stats_controller.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatsController());
    final colors = Theme.of(context).extension<GameColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.boardBackground,
      appBar: AppBar(
        title: Text(
          'Statistics',
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

        return RefreshIndicator(
          onRefresh: () async {
            // controller.reload
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24.0).copyWith(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Level & XP Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.accent,
                        AppTheme.accent.withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accent.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Level ${controller.level.value}',
                        style: textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        controller.levelTitle.value,
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${controller.currentXP.value} XP',
                              style: const TextStyle(color: Colors.white)),
                          Text('${controller.nextLevelXP.value} XP',
                              style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: controller.progressToNext.value,
                          minHeight: 12,
                          backgroundColor: Colors.black.withValues(alpha: 0.2),
                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                        ),
                      ).animate().scaleX(begin: 0, duration: 1000.ms, curve: Curves.easeOutCirc),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),

                const SizedBox(height: 32),

                // Global Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _StatBox(
                        title: 'Puzzles Solved',
                        value: '${controller.totalPuzzlesSolved}',
                        icon: Icons.grid_on,
                        delay: 200,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatBox(
                        title: 'Total XP',
                        value: '${controller.totalXP.value}',
                        icon: Icons.star,
                        delay: 300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _StatBox(
                        title: 'Mistakes',
                        value: '${controller.totalMistakes.value}',
                        icon: Icons.close,
                        delay: 400,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatBox(
                        title: 'Hints Used',
                        value: '${controller.totalHints.value}',
                        icon: Icons.lightbulb,
                        delay: 500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                Text(
                  'Difficulty Breakdown',
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ).animate().fadeIn(delay: 600.ms),
                const SizedBox(height: 16),

                // Breakdown list
                ...Difficulty.values.asMap().entries.map((entry) {
                  final index = entry.key;
                  final diff = entry.value;
                  final count = controller.puzzlesPerDifficulty[diff] ?? 0;
                  final maxCount = controller.totalPuzzlesSolved > 0 ? controller.totalPuzzlesSolved : 1;
                  final progress = count / maxCount;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              diff.name.toUpperCase(),
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _getColorForDiff(diff),
                              ),
                            ),
                            Text(
                              '$count solved',
                              style: textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor: colors.cellBorder,
                            valueColor: AlwaysStoppedAnimation(_getColorForDiff(diff)),
                          ),
                        ).animate().scaleX(begin: 0, delay: (800 + index * 100).ms, duration: 600.ms, curve: Curves.easeOut),
                      ],
                    ),
                  ).animate().fadeIn(delay: (700 + index * 100).ms);
                }),
              ],
            ),
          ),
        );
      }),
    );
  }

  Color _getColorForDiff(Difficulty d) {
    switch (d) {
      case Difficulty.easy: return Colors.green;
      case Difficulty.medium: return Colors.blue;
      case Difficulty.hard: return Colors.orange;
      case Difficulty.master: return Colors.red;
      case Difficulty.extreme: return Colors.purple;
    }
  }
}

class _StatBox extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final int delay;

  const _StatBox({
    required this.title,
    required this.value,
    required this.icon,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.accent, size: 28),
          const SizedBox(height: 16),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.1);
  }
}
