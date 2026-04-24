import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../app/app.dart';
import '../core/puzzle/models.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  /// Stores notification data when the app was launched from a terminated state.
  /// The splash screen will consume this after navigation is ready.
  Map<String, dynamic>? pendingNotificationData;

  /// Completer that resolves once the initial message check is done.
  /// This lets the splash screen await it before checking pendingNotificationData.
  final Completer<void> _initialMessageChecked = Completer<void>();
  Future<void> get initialMessageChecked => _initialMessageChecked.future;

  /// Global store for the latest notification data to ensure it survives
  /// cold starts where Get.arguments might be lost.
  static Map<String, dynamic>? lastMessageData;

  Future<void> init() async {
    // 1. Check initial message FIRST — this is the terminated-state tap.
    //    Must happen before any async network calls that could delay things.
    try {
      RemoteMessage? initialMessage = await _fcm.getInitialMessage();
      if (initialMessage != null) {
        pendingNotificationData = initialMessage.data;
        lastMessageData = initialMessage.data; // Store immediately for GameController
        print('--- TERMINATED STATE NOTIFICATION ---');
        print('RAW DATA: ${initialMessage.data}');
        print('-------------------------------------');
      }
    } catch (e) {
      debugPrint('Error checking initial message: $e');
    } finally {
      // Signal that the initial message check is done regardless of success/failure
      if (!_initialMessageChecked.isCompleted) {
        _initialMessageChecked.complete();
      }
    }

    // 2. Request permission
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    // 3. Get FCM token
    await getAndPrintToken();

    // 4. Subscribe to topics
    await _fcm.subscribeToTopic('daily_challenge');
    await _fcm.subscribeToTopic('sudoku_events');
    print('Subscribed to topics: daily_challenge, sudoku_events');

    // 5. Setup Local Notifications for Android foreground
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // This fires when user taps a LOCAL notification shown in FOREGROUND
        if (response.payload != null) {
          final data = jsonDecode(response.payload!) as Map<String, dynamic>;
          _navigateToGame(data);
        }
      },
    );

    // 6. Setup Android Channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'sudoku_channel',
      'Sudoku Notifications',
      description: 'Notifications for Sudoku App',
      importance: Importance.max,
    );

    final platformPlugin = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (platformPlugin != null) {
      await platformPlugin.createNotificationChannel(channel);
    }

    // 7. Handle Foreground Messages — show a local notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _localNotifications.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });

    // 8. Handle Background → Foreground tap (app was in background, not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp: ${message.data}');
      _navigateToGame(message.data);
    });
  }

  /// Called by splash screen for the terminated-state case.
  /// Also called directly for background/foreground taps.
  void handleMessageData(Map<String, dynamic> data) {
    _navigateToGame(data);
  }

  /// Core navigation logic — works for all three states.
  void _navigateToGame(Map<String, dynamic> data) {
    print('NotificationService: Processing navigation with data: $data');
    
    // Store globally as a last-resort for GameController
    lastMessageData = data;

    if (!data.containsKey('route')) {
      print('NotificationService: No route found in data, ignoring navigation');
      return;
    }

    final route = data['route'];
    if (route == '/game') {
      // Check multiple keys for difficulty
      final difficultyRaw = data['difficulty'] ?? data['level'] ?? data['diff'];
      final difficultyStr = difficultyRaw?.toString() ?? 'easy';
      
      final diffEnum = Difficulty.values.firstWhere(
        (e) => e.name.toLowerCase() == difficultyStr.toLowerCase(),
        orElse: () => Difficulty.easy,
      );

      print('NotificationService: Target difficulty: ${diffEnum.name}');
      
      // Store globally as a last-resort for GameController
      // We store the enum here for internal safety
      lastMessageData = {
        'action': 'new',
        'difficulty': diffEnum.name,
      };

      // Navigate: clear stack and go directly to game with arguments.
      // Since ThemeController is now permanent in main.dart, this is safe and stable.
      Get.offAllNamed(
        '/game',
        arguments: {
          'action': 'new',
          'difficulty': diffEnum.name, // Pass as string for better reliability
        },
      );
    }
  }

  Future<void> getAndPrintToken() async {
    try {
      String? token = await _fcm.getToken();
      if (token != null) {
        print('---------------- FCM DEBUG TOKEN ----------------');
        print('TOKEN: $token');
        print('-------------------------------------------------');
        
        // Also copy to clipboard for convenience
        // await Clipboard.setData(ClipboardData(text: token));
      } else {
        print('FCM Token is null');
      }
    } catch (e) {
      print('Error getting FCM token: $e');
    }
  }
}
