// lib/features/game/win_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/theme/app_theme.dart';
import '../../core/puzzle/models.dart';
import '../gamification/achievement_definitions.dart';
import '../../core/ads/ad_service.dart';

class WinScreen extends StatefulWidget {
  const WinScreen({super.key});

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  late final GameResult result;
  late final bool leveledUp;
  late final int newLevel;
  late final List<String> newAchievements;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    result = args?['result'] as GameResult;
    leveledUp = args?['leveledUp'] as bool? ?? false;
    newLevel = args?['newLevel'] as int? ?? 1;
    newAchievements = args?['newAchievements'] as List<String>? ?? [];
  }

  void _shareResult() {
    final diff = result.difficulty.name.toUpperCase();
    final timeStr = "${result.elapsed.inMinutes}:${(result.elapsed.inSeconds % 60).toString().padLeft(2, '0')}";
    String text = "I just solved a $diff Sudoku puzzle in $timeStr on Sudoku Master!\n"
        "⭐ Earned ${result.xpEarned} XP\n"
        "❌ Mistakes: ${result.mistakes}\n"
        "💡 Hints: ${result.hintsUsed}";
    
    if (leveledUp) {
      text += "\n🎉 I leveled up to Level $newLevel!";
    }
    Share.share(text);
  }
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<GameColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.boardBackground,
      body: Stack(
        children: [
          // Background Confetti
          Positioned.fill(
            child: Lottie.asset(
              'assets/lottie/confetti.json',
              repeat: false,
              fit: BoxFit.cover,
            ),
          ),
          
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Victory Header
                      Icon(
                        Icons.emoji_events,
                        size: 80,
                        color: AppTheme.accent,
                      ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                      const SizedBox(height: 16),
                      Text(
                        'P U Z Z L E   S O L V E D',
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppTheme.accent,
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),

                    const SizedBox(height: 40),

                    // Stats Card
                    Container(
                      padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                      child: Column(
                        children: [
                          _StatRow(
                            icon: Icons.timer,
                            label: 'Time',
                            value: "${result.elapsed.inMinutes}:${(result.elapsed.inSeconds % 60).toString().padLeft(2, '0')}",
                            delay: 600,
                          ),
                          const Divider(height: 24),
                          _StatRow(
                            icon: Icons.close,
                            label: 'Mistakes',
                            value: '${result.mistakes}',
                            delay: 800,
                          ),
                          const Divider(height: 24),
                          _StatRow(
                            icon: Icons.lightbulb,
                            label: 'Hints Used',
                            value: '${result.hintsUsed}',
                            delay: 1000,
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'XP Earned',
                                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                  children: [
                                    Icon(Icons.star, color: AppTheme.accent, size: 28)
                                      .animate(onPlay: (controller) => controller.repeat())
                                      .shimmer(duration: 2000.ms, color: Colors.white),
                                    const SizedBox(width: 8),
                                    // Animated counter for XP
                                    TweenAnimationBuilder<int>(
                                      tween: IntTween(begin: 0, end: result.xpEarned),
                                      duration: const Duration(milliseconds: 1500),
                                      curve: Curves.easeOut,
                                      builder: (context, value, child) {
                                        return Text(
                                          '+$value',
                                          style: textTheme.headlineSmall?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: AppTheme.accent,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                            ],
                          ).animate().fadeIn(delay: 1200.ms).slideX(begin: 0.1),
                        ],
                      ),
                    ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.9, 0.9)),

                    const SizedBox(height: 32),

                    // Level Up Banner
                    if (leveledUp)
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.accent, AppTheme.accent.withValues(alpha: 0.7)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_upward, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              'LEVEL UP! You reached Level $newLevel',
                              style: textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ).animate()
                          .fadeIn(delay: 1800.ms)
                          .slideY(begin: 0.5)
                          .shimmer(delay: 2500.ms, duration: const Duration(seconds: 1)),

                    const SizedBox(height: 24),

                    // New Achievements
                    if (newAchievements.isNotEmpty) ...[
                      Text('New achievements unlocked!', style: textTheme.titleSmall),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: newAchievements.length,
                          itemBuilder: (context, index) {
                            final id = newAchievements[index];
                            final def = AchievementDefinitions.all.firstWhere((a) => a.id == id);
                            // Ensure icon name matches standard material icons mapping or use fallback
                            IconData iconData = _getIconData(def.icon);
                            
                            return Container(
                                width: 64,
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: AppTheme.accent.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppTheme.accent, width: 2),
                                ),
                                child: Center(
                                  child: Icon(iconData, color: AppTheme.accent, size: 32),
                                ),
                              ).animate()
                                .scale(delay: (2000 + (index * 200)).ms, duration: 500.ms, curve: Curves.elasticOut);
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              AdService.to.showInterstitialIfAppropriate(
                                onComplete: () => Get.offAllNamed('/home'),
                              );
                            },
                            icon: const Icon(Icons.home),
                            label: const Text('Home'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: _shareResult,
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                            style: FilledButton.styleFrom(
                                backgroundColor: AppTheme.accent,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 2400.ms).slideY(begin: 0.2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Basic string-to-icon mapping for standard set
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

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final int delay;

  const _StatRow({required this.icon, required this.label, required this.value, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.grey, size: 24),
            const SizedBox(width: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1);
  }
}
