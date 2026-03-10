// lib/features/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../app/controllers/theme_controller.dart';
import '../game/controller/game_controller.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.put(HomeController());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh state when coming back from game screen
    _ctrl.refreshState();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // SafeArea + custom padding
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Header ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_getGreeting()},',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                        ),
                      ),
                      Text(
                        'Solver!',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  
                  // Theme Toggle
                  IconButton(
                    icon: Icon(
                      Get.find<ThemeController>().themeMode.value == ThemeMode.dark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                    ),
                    onPressed: () => Get.find<ThemeController>().toggleTheme(),
                  ),
                ],
              ),
            ),
            
            // ── XP & Streak Block ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // XP Progress
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Text(
                                'Level ${_ctrl.level.value}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )),
                              Obx(() => Text(
                                '${_ctrl.totalXP.value % 1000} / 1000 XP',
                                style: TextStyle(fontSize: 12, color: theme.hintColor),
                              )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Obx(() => LinearProgressIndicator(
                            value: _ctrl.levelProgress,
                            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                            borderRadius: BorderRadius.circular(4),
                            minHeight: 6,
                          )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Streak
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🔥', style: TextStyle(fontSize: 24))
                            .animate(onPlay: (controller) => controller.repeat())
                            .shimmer(duration: 2000.ms, color: Colors.orangeAccent),
                        const SizedBox(height: 4),
                        Obx(() => Text(
                          '${_ctrl.streakDays.value} days',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── Middle Actions ───────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Active Game Resume Card
                  Obx(() {
                    if (!_ctrl.hasActiveGame.value || _ctrl.activeGame.value == null) {
                      return const SizedBox.shrink();
                    }
                    final game = _ctrl.activeGame.value!;
                    final m = game.elapsedSeconds ~/ 60;
                    final s = game.elapsedSeconds % 60;
                    final time = '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          // Pass saved game state to controller, then route
                          if (!Get.isRegistered<GameController>()) {
                            Get.lazyPut(() => GameController());
                          }
                          Get.find<GameController>().resumeSavedGame(game);
                          Get.toNamed('/game');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary.withValues(alpha: 0.8),
                                theme.colorScheme.primary,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'RESUME GAME',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.2,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${game.difficulty.capitalizeFirst} • $time',
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms, curve: Curves.easeOut).fadeIn(),
                    );
                  }),

                  // New Game Card
                  GestureDetector(
                    onTap: () => Get.toNamed('/difficulty'),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add_box_rounded, color: theme.colorScheme.primary, size: 36),
                          const SizedBox(width: 16),
                          const Text(
                            'NEW GAME',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().slideY(begin: 0.2, end: 0, delay: 100.ms, duration: 400.ms, curve: Curves.easeOut).fadeIn(),

                  const SizedBox(height: 16),

                  // Daily Challenge Card
                  GestureDetector(
                    onTap: () {
                      final today = DateTime.now().toIso8601String().split('T')[0];
                      if (!Get.isRegistered<GameController>()) {
                            Get.lazyPut(() => GameController());
                      }
                      Get.find<GameController>().startDailyGame(today);
                      Get.toNamed('/game');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_rounded, color: const Color(0xFF16A34A), size: 32),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DAILY CHALLENGE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Earn 2x XP today!',
                                  style: TextStyle(color: Colors.grey, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 400.ms, curve: Curves.easeOut).fadeIn(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 28), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard_rounded, size: 28), label: 'Ranks'),
          BottomNavigationBarItem(icon: Icon(Icons.event_rounded, size: 28), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events_rounded, size: 28), label: 'Awards'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded, size: 28), label: 'Stats'),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Get.toNamed('/leaderboard');
          } else if (index == 2) {
            Get.toNamed('/events');
          } else if (index == 3) {
            Get.toNamed('/achievements');
          } else if (index == 4) {
            Get.toNamed('/stats');
          }
        },
      ),
    );
  }
}
