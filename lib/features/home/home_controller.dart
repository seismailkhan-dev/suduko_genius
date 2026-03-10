// lib/features/home/home_controller.dart

import 'package:get/get.dart';
import '../../core/db/app_database.dart';
import '../../core/db/db_service.dart';

class HomeController extends GetxController {
  final hasActiveGame = false.obs;
  late final Rx<SavedGame?> activeGame = Rx<SavedGame?>(null);

  final streakDays = 0.obs;
  final level = 1.obs;
  final totalXP = 0.obs;

  final activeEvent = Rx<String?>(null); // From Remote Config (stubbed)

  @override
  void onInit() {
    super.onInit();
    _loadState();
  }

  Future<void> _loadState() async {
    final db = DbService.instance;

    // 1. Check for active saved game
    final games = await db.savedGames.getAllGames();
    if (games.isNotEmpty) {
      // Sort to get most recently updated
      games.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      activeGame.value = games.first;
      hasActiveGame.value = true;
    } else {
      activeGame.value = null;
      hasActiveGame.value = false;
    }

    // 2. Load basic user stats
    final stats = await db.userStats.getStats();
    if (stats != null) {
      streakDays.value = stats.streakDays;
      level.value = stats.level;
      totalXP.value = stats.totalXP;
    }

    // 3. Stub remote config event check (simulates real network call)
    // In reality, we'd use unawaited(FirebaseRemoteConfig.instance.fetchAndActivate())
    activeEvent.value = null; // e.g. "Spring Tournament"
  }

  int get xpForNextLevel => level.value * 1000;
  double get levelProgress => totalXP.value % 1000 / 1000.0;

  void refreshState() {
    _loadState();
  }
}
