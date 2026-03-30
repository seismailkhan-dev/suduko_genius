// lib/core/ads/ad_ids.dart

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AdIds {
  static const bool useTestingAds = kDebugMode; // Force test ads in debug

  // -- App IDs -- //
  static const String androidAppId = 'ca-app-pub-2566803316266112~1079482919';
  static const String iosAppId = 'ca-app-pub-3940256099942544';

  // -- Banner Ads -- //
  static String get bannerAdUnitId {
    if (useTestingAds) {
      return GetPlatform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111' // Official Test ID
          : 'ca-app-pub-3940256099942544/2934735716'; // Official Test ID
    }
    return GetPlatform.isAndroid
        ? 'ca-app-pub-2566803316266112/9991853009'
        : 'ca-app-pub-3940256099942544/2934735716';
  }

  // -- Interstitial Ads -- //
  static String get interstitialAdUnitId {
    if (useTestingAds) {
      return GetPlatform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712' // Official Test ID
          : 'ca-app-pub-3940256099942544/4411468910'; // Official Test ID
    }
    return GetPlatform.isAndroid
        ? 'ca-app-pub-2566803316266112/5274712945'
        : 'ca-app-pub-3940256099942544/4411468910';
  }

  // -- Rewarded Ads -- //
  static String get rewardedAdUnitId {
    if (useTestingAds) {
      return GetPlatform.isAndroid
          ? 'ca-app-pub-3940256099942544/5224354917' // Official Test ID
          : 'ca-app-pub-3940256099942544/1712485313'; // Official Test ID
    }
    return GetPlatform.isAndroid
        ? 'ca-app-pub-2566803316266112/3965500706'
        : 'ca-app-pub-3940256099942544/1712485313';
  }
}
