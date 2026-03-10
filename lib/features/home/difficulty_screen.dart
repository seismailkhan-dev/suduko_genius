// lib/features/home/difficulty_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../core/puzzle/models.dart';
import '../game/controller/game_controller.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // List of definitions for the UI
    final levels = [
      (diff: Difficulty.easy, emoji: '🌱', time: '3-5 min', color: const Color(0xFF16A34A)),
      (diff: Difficulty.medium, emoji: '⚡', time: '5-10 min', color: const Color(0xFFD97706)),
      (diff: Difficulty.hard, emoji: '🔥', time: '10-20 min', color: const Color(0xFFDC2626)),
      (diff: Difficulty.master, emoji: '🧠', time: '20-30 min', color: const Color(0xFF7C4DFF)),
      (diff: Difficulty.extreme, emoji: '💀', time: '30+ min', color: const Color(0xFF111827)),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Select Difficulty',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final l = levels[index];
          final isExtreme = l.diff == Difficulty.extreme;

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GestureDetector(
              onTap: () {
                if (!Get.isRegistered<GameController>()) {
                  Get.lazyPut(() => GameController());
                }
                Get.find<GameController>().startGame(l.diff);
                Get.offNamed('/game');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: isExtreme && theme.brightness == Brightness.dark 
                      ? const Color(0xFF1A1A28) 
                      : theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isExtreme ? l.color.withValues(alpha: 0.5) : theme.dividerColor.withValues(alpha: 0.1),
                    width: isExtreme ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(l.emoji, style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                l.diff.displayName,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                ),
                              ),
                              if (isExtreme) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: l.color.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: l.color.withValues(alpha: 0.3)),
                                  ),
                                  child: Text(
                                    'EXPERT',
                                    style: TextStyle(
                                      color: theme.brightness == Brightness.dark ? Colors.redAccent : l.color,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Typical time: ${l.time}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: theme.iconTheme.color?.withValues(alpha: 0.3),
                    ),
                  ],
                ),
              ),
            )
            .animate()
            .slideX(begin: 0.1, end: 0, duration: 400.ms, delay: (index * 100).ms, curve: Curves.easeOut)
            .fadeIn(duration: 400.ms, delay: (index * 100).ms),
          );
        },
      ),
    );
  }
}
