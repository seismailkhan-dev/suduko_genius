// lib/core/analytics/analytics_service.dart

import 'package:get/get.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService extends GetxService {
  static AnalyticsService get to => Get.find<AnalyticsService>();
  
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<AnalyticsService> init() async {
    return this;
  }

  void logGameStart(String difficulty) {
    _analytics.logEvent(
      name: 'level_start',
      parameters: {
        'level_name': difficulty,
      },
    );
  }

  void logGameEnd(String difficulty, bool isWin, int mistakes, int timeSeconds) {
    _analytics.logEvent(
      name: 'level_end',
      parameters: {
        'level_name': difficulty,
        'success': isWin ? 'true' : 'false',
        'mistakes': mistakes,
        'duration_seconds': timeSeconds,
      },
    );
  }

  void logHintUsed() {
    _analytics.logEvent(name: 'hint_used');
  }

  void logMistake() {
    _analytics.logEvent(name: 'mistake_made');
  }

  void logAdRevenue({
    required String adUnitId,
    required String format,
    required double valueMicros,
    required String currencyCode,
  }) {
    _analytics.logAdImpression(
      adPlatform: 'admob',
      adSource: 'admob',
      adFormat: format,
      adUnitName: adUnitId,
      currency: currencyCode,
      value: valueMicros / 1000000.0,
    );
  }
}
