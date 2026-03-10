// lib/features/leaderboard/leaderboard_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_theme.dart';
import '../../core/firebase/auth_service.dart';
import '../../core/firebase/firestore_service.dart';
import '../../shared/widgets/ad_banner_widget.dart';
import 'leaderboard_controller.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaderboardController());
    final theme = Theme.of(context);
    final gameColors = theme.extension<GameColors>()!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'LEADERBOARDS',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          _buildTabBar(controller, theme),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.entries.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.entries.isEmpty) {
                return Center(
                  child: Text(
                    'No rankings yet.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.refreshData,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: controller.entries.length,
                  itemBuilder: (context, index) {
                    final entry = controller.entries[index];
                    final isMe = entry.userId == AuthService.to.uid;
                    return _buildEntryRow(index + 1, entry, isMe, theme, gameColors);
                  },
                ),
              );
            }),
          ),
          Obx(() {
            if (controller.userRank.value > 0) {
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.emoji_events, color: theme.colorScheme.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'YOUR RANK: #${controller.userRank.value}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ).animate().slideY(begin: 1, end: 0);
            }
            return const SizedBox.shrink();
          }),
          const AdBannerWidget(),
        ],
      ),
    );
  }

  Widget _buildTabBar(LeaderboardController controller, ThemeData theme) {
    final tabs = ['daily', 'easy', 'medium', 'hard', 'master', 'extreme'];
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          return Obx(() {
            final isSelected = controller.selectedTab.value == tab;
            return GestureDetector(
              onTap: () => controller.onTabChanged(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.primary : theme.cardColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: isSelected
                      ? [BoxShadow(color: theme.colorScheme.primary.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 4))]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  tab.toUpperCase(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildEntryRow(int rank, LeaderboardEntry entry, bool isMe, ThemeData theme, GameColors gameColors) {
    Color rankColor;
    if (rank == 1) {
      rankColor = const Color(0xFFFFD700);
    } else if (rank == 2) {
      rankColor = const Color(0xFFC0C0C0);
    } else if (rank == 3) {
      rankColor = const Color(0xFFCD7F32);
    } else {
      rankColor = theme.textTheme.bodySmall?.color ?? Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMe ? theme.colorScheme.primary.withValues(alpha: 0.1) : theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isMe ? Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3), width: 2) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: rank <= 3 ? rankColor.withValues(alpha: 0.2) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$rank',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: rankColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.displayName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: isMe ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
                Text(
                  'LVL ${entry.level} • ${entry.puzzlesSolved} SOLVED',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entry.score}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.primary,
                ),
              ),
              Text(
                'TOTAL XP',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: (rank * 50).ms).slideX(begin: 0.1, end: 0);
  }
}
