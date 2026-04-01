// lib/shared/widgets/ad_banner_widget.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../app/controllers/settings_controller.dart';
import '../../core/analytics/analytics_service.dart';
import '../../core/ads/ad_ids.dart';

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    // Check global DI state to see if user purchased "remove ads"
    if (Get.find<SettingsController>().isAdsRemoved.value) return;

    _bannerAd = BannerAd(
      adUnitId: AdIds.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {
          AnalyticsService.to.logAdRevenue(
            adUnitId: ad.adUnitId,
            format: 'banner',
            valueMicros: valueMicros,
            currencyCode: currencyCode,
          );
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null && _isLoaded) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
