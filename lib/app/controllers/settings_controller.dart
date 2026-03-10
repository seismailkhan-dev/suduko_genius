// lib/app/controllers/settings_controller.dart

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  final isAdsRemoved = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    isAdsRemoved.value = prefs.getBool('adsRemoved') ?? false;
  }

  Future<void> removeAds() async {
    isAdsRemoved.value = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('adsRemoved', true);
  }
}
