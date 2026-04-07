// lib/app/app.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../features/game/game_screen.dart';
import '../features/home/difficulty_screen.dart';
import '../features/home/home_screen.dart';
import '../features/leaderboard/leaderboard_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/game/win_screen.dart';
import '../features/achievements/achievements_screen.dart';
import '../features/events/events_screen.dart';
import '../features/stats/stats_screen.dart';
import 'bindings/game_binding.dart';
import 'controllers/theme_controller.dart';
import 'theme/app_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject ThemeController globally
    final themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
          navigatorKey: navigatorKey,
          title: 'Sudoku Genius',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode.value,
          initialRoute: '/splash',
          getPages: [
            GetPage(
              name: '/splash',
              page: () => const SplashScreen(),
              transition: Transition.fadeIn,
            ),
            GetPage(
              name: '/home',
              page: () => const HomeScreen(),
              transition: Transition.fadeIn,
            ),
            GetPage(
              name: '/difficulty',
              page: () => const DifficultyScreen(),
              transition: Transition.rightToLeftWithFade,
            ),
            GetPage(
              name: '/game',
              page: () => const GameScreen(),
              binding: GameBinding(),
              transition: Transition.downToUp,
            ),
            GetPage(
          name: '/leaderboard',
          page: () => const LeaderboardScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/events',
          page: () => const EventsScreen(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/win',
          page: () => const WinScreen(),
          transition: Transition.zoom,
        ),
        GetPage(
          name: '/achievements',
          page: () => const AchievementsScreen(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/stats',
          page: () => const StatsScreen(),
          transition: Transition.cupertino,
        ),
      ],
        ));
  }
}
