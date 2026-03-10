// lib/features/achievements/achievements_controller.dart

import 'package:get/get.dart';
import '../../core/db/db_service.dart';

class AchievementsController extends GetxController {
  final db = DbService.instance;
  
  final unlockedIds = <String>{}.obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUnlocked();
  }

  Future<void> _loadUnlocked() async {
    isLoading.value = true;
    try {
      final records = await db.achievements.getUnlocked();
      unlockedIds.assignAll(records.map((e) => e.id));
    } finally {
      isLoading.value = false;
    }
  }
}
