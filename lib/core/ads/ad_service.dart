// lib/core/ads/ad_service.dart

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../app/controllers/settings_controller.dart';
import '../analytics/analytics_service.dart';
import 'ad_ids.dart';

class AdService extends GetxService {
  static AdService get to => Get.find();

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  bool _isInterstitialLoading = false;
  bool _isRewardedLoading = false;

  int _gamesSinceLastInterstitial = 0;
  
  // Using 2 here means the first win doesn't show an ad, but the second one does.
  static const int _interstitialFrequency = 2; 

  bool get adsRemoved => Get.find<SettingsController>().isAdsRemoved.value;

  /// Loads the AdMob SDK SDK and preloads full-screen ads.
  Future<AdService> init() async {
    await MobileAds.instance.initialize();
    _tryLoadAds();
    return this;
  }

  void _tryLoadAds() {
    if (adsRemoved) return;
    _loadInterstitial();
    _loadRewarded();
  }

  /// --------------------------------------------------------------------------
  /// Interstitial Ads
  /// --------------------------------------------------------------------------

  void _loadInterstitial() {
    if (adsRemoved || _isInterstitialLoading || _interstitialAd != null) return;
    _isInterstitialLoading = true;

    InterstitialAd.load(
      adUnitId: AdIds.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('InterstitialAd loaded.');
          _interstitialAd = ad;
          _interstitialAd!.onPaidEvent = (ad, valueMicros, precision, currencyCode) {
            AnalyticsService.to.logAdRevenue(
              adUnitId: ad.adUnitId,
              format: 'interstitial',
              valueMicros: valueMicros,
              currencyCode: currencyCode,
            );
          };
          _isInterstitialLoading = false;
        },
        onAdFailedToLoad: (error) {
          debugPrint('InterstitialAd failed to load: $error');
          _isInterstitialLoading = false;
        },
      ),
    );
  }

  /// Attempts to show an interstitial ad (e.g. after a game ends).
  /// If the user bought 'remove ads' or the ad isn't loaded, [onComplete] fires immediately.
  /// Throttled by [_interstitialFrequency].
  void showInterstitialIfAppropriate({required VoidCallback onComplete}) {
    if (adsRemoved) {
      onComplete();
      return;
    }

    _gamesSinceLastInterstitial++;
    
    if (_gamesSinceLastInterstitial < _interstitialFrequency || _interstitialAd == null) {
      onComplete();
      return;
    }

    // Reset counter
    _gamesSinceLastInterstitial = 0;

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitial();
        onComplete();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('InterstitialAd failed to show: $error');
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitial();
        onComplete();
      },
    );

    _interstitialAd!.show();
  }

  /// --------------------------------------------------------------------------
  /// Rewarded Ads
  /// --------------------------------------------------------------------------

  void _loadRewarded() {
    if (adsRemoved || _isRewardedLoading || _rewardedAd != null) return;
    _isRewardedLoading = true;

    RewardedAd.load(
      adUnitId: AdIds.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('RewardedAd loaded.');
          _rewardedAd = ad;
          _rewardedAd!.onPaidEvent = (ad, valueMicros, precision, currencyCode) {
            AnalyticsService.to.logAdRevenue(
              adUnitId: ad.adUnitId,
              format: 'rewarded',
              valueMicros: valueMicros,
              currencyCode: currencyCode,
            );
          };
          _isRewardedLoading = false;
        },
        onAdFailedToLoad: (error) {
          debugPrint('RewardedAd failed to load: $error');
          _isRewardedLoading = false;
        },
      ),
    );
  }

  /// Shows a rewarded ad for a Hint.
  void showRewardedForHint({
    required VoidCallback onRewarded,
    required VoidCallback onClosed,
  }) {
    // If ads are removed, they get unlimited hints automatically without an ad.
    if (adsRemoved) {
      onRewarded();
      onClosed();
      return;
    }

    if (_rewardedAd == null) {
      // Ad isn't ready. Gracefully fallback (give them the reward anyway or show an error toast)
      // Here we choose to be generous if our inventory fails to load.
      debugPrint('Rewarded ad not ready. Granting reward fallback.');
      onRewarded();
      onClosed();
      _loadRewarded();
      return;
    }

    bool earnedReward = false;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        _loadRewarded();
        onClosed();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('RewardedAd failed to show: $error');
        ad.dispose();
        _rewardedAd = null;
        _loadRewarded();
        onClosed(); // Treat as failure
      },
    );

    _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      earnedReward = true;
      onRewarded();
    });
  }

  /// Shows a rewarded ad for an Extra Life.
  void showRewardedForLife({
    required VoidCallback onRewarded,
    required VoidCallback onClosed,
  }) {
    if (adsRemoved) {
      onRewarded();
      onClosed();
      return;
    }

    if (_rewardedAd == null) {
      debugPrint('Rewarded ad not ready. Granting life fallback.');
      onRewarded();
      onClosed();
      _loadRewarded();
      return;
    }

    bool earnedReward = false;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        _loadRewarded();
        onClosed();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('RewardedAd failed to show: $error');
        ad.dispose();
        _rewardedAd = null;
        _loadRewarded();
        onClosed();
      },
    );

    _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      earnedReward = true;
      onRewarded();
    });
  }
}
