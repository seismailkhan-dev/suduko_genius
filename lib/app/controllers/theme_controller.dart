// lib/app/controllers/theme_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const _themeKey = 'isDarkMode';
  
  final themeMode = Rx<ThemeMode>(ThemeMode.system);
  late final SharedPreferences _prefs;

  @override
  void onInit() {
    super.onInit();
    _initTheme();
  }

  Future<void> _initTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final isDark = _prefs.getBool(_themeKey);
    if (isDark != null) {
      themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void toggleTheme() {
    final isCurrentlyDark = themeMode.value == ThemeMode.dark ||
        (themeMode.value == ThemeMode.system && Get.isPlatformDarkMode);
    
    themeMode.value = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
    _prefs.setBool(_themeKey, themeMode.value == ThemeMode.dark);
  }
}
