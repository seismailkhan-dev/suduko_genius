// lib/features/splash/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/db/db_service.dart';
import '../../core/firebase/auth_service.dart';
import '../../app/controllers/settings_controller.dart';
import '../../core/ads/ad_service.dart';
import '../../services/notification_service.dart';
import '../gamification/achievement_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // 1. Minimum logo display time
    final timer = Future.delayed(const Duration(seconds: 2));

    // 2. Initialize core services gracefully
    try {
      await Future.wait([
        DbService.instance.init(),
        MobileAds.instance.initialize().timeout(
          const Duration(seconds: 3),
          onTimeout: () => InitializationStatus({}),
        ),
      ]);

      // Trigger internal async init for services already in Get
      await AuthService.to.init().timeout(
        const Duration(seconds: 3),
        onTimeout: () {},
      );
      // Register global settings and gamification services
      Get.put(AchievementService(DbService.instance.database), permanent: true);
      
      // Initialize and register AdService
      await Get.put(AdService(), permanent: true).init().timeout(
        const Duration(seconds: 3),
        onTimeout: () => Get.find<AdService>(),
      );
    } catch (e) {
      debugPrint('Initialization error: $e');
    }

    // Ensure the initial message check has completed before we read it
    await NotificationService().initialMessageChecked.timeout(
      const Duration(seconds: 2),
      onTimeout: () {
        debugPrint('Initial message check timed out in splash');
      },
    );

    // Wait for the minimum time to pass so the splash animation finishes.
    await timer;

    // Grab pending data BEFORE navigating away from splash
    final notifService = NotificationService();
    final pendingData = notifService.pendingNotificationData;

    if (pendingData != null) {
      // Clear it so it's not processed again
      notifService.pendingNotificationData = null;

      // Let the notification service handle navigation directly
      notifService.handleMessageData(pendingData);
    } else {
      // No notification — just go to home
      Get.offAllNamed('/home');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.grid_on_rounded,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
                .animate()
                .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0), duration: 800.ms, curve: Curves.easeOutBack)
                .fadeIn(duration: 800.ms),
            
            const SizedBox(height: 24),

            // Animated text
            Text(
              'Sudoku Genius',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
            )
                .animate(delay: 400.ms)
                .slideY(begin: 0.5, end: 0, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(),
          ],
        ),
      ),
    );
  }
}
