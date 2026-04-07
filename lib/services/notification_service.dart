import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../app/app.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Request permission
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    // Get FCM token
    String? token = await _fcm.getToken();
    print('FCM Device Token: $token');

    // Subscribe to topics
    await _fcm.subscribeToTopic('daily_challenge');
    await _fcm.subscribeToTopic('sudoku_events');
    print('Subscribed to topics: daily_challenge, sudoku_events');

    // Setup Local Notifications for Android foreground
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
        if (response.payload != null) {
          final data = jsonDecode(response.payload!);
          _handleMessageData(data);
        }
      },
    );

    // Setup Android Channel
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

    // Handle Foreground Messages
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

    // Handle Background Tapped Messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessageData(message.data);
    });

    // Handle Terminated App Tapped Messages
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      // Need a slight delay to allow navigation structure to build
      Future.delayed(const Duration(milliseconds: 500), () {
        _handleMessageData(initialMessage.data);
      });
    }
  }

  void _handleMessageData(Map<String, dynamic> data) {
    print('Handling notification data: $data');
    if (data.containsKey('route')) {
      final route = data['route'];
      final difficulty = data['difficulty'];
      
      if (route == '/game' && navigatorKey.currentState != null) {
        navigatorKey.currentState!.pushNamed(
          route,
          arguments: difficulty,
        );
      }
    }
  }
}
