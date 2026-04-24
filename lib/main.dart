import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'app/controllers/settings_controller.dart';
import 'app/controllers/theme_controller.dart';
import 'core/analytics/analytics_service.dart';
import 'core/firebase/auth_service.dart';
import 'core/firebase/firestore_service.dart';
import 'firebase_options.dart';
import 'services/notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  Get.put(SettingsController(), permanent: true);
  Get.put(ThemeController(), permanent: true);
  
  // Initialize Firebase FIRST
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Register services immediately 
  Get.put(AuthService());
  Get.put(FirestoreService());
  Get.put(AnalyticsService());

  // Start notification init (non-blocking for the full init),
  // but we MUST wait for the initial message check so the splash screen
  // can reliably read pendingNotificationData.
  final notificationService = NotificationService();
  notificationService.init().catchError((e) {
    debugPrint('Notification init error: $e');
  });

  // Wait for just the initial message check (fast, no network calls)
  // with a timeout so we never block app startup indefinitely.
  await notificationService.initialMessageChecked.timeout(
    const Duration(seconds: 2),
    onTimeout: () {
      debugPrint('Initial message check timed out, proceeding without it');
    },
  );

  runApp(const App());
}
