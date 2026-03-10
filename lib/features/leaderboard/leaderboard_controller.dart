// lib/features/leaderboard/leaderboard_controller.dart

import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/firebase/firestore_service.dart';
import '../../core/puzzle/models.dart';

class LeaderboardController extends GetxController {
  final selectedTab = Rx<String>('medium');
  final entries = RxList<LeaderboardEntry>([]);
  final userRank = RxInt(-1);
  final isLoading = RxBool(true);

  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    _fetchEntries();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  void onTabChanged(String tab) {
    if (selectedTab.value == tab) return;
    selectedTab.value = tab;
    _fetchEntries();
  }

  void _fetchEntries() {
    isLoading.value = true;
    _subscription?.cancel();

    if (selectedTab.value == 'daily') {
      final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
      _subscription = FirestoreService.to.fetchDailyLeaderboard(dateStr).listen((data) {
        entries.assignAll(data);
        isLoading.value = false;
        // Simplified rank for daily
        userRank.value = -1; 
      });
    } else {
      final diff = Difficulty.values.firstWhere((d) => d.name == selectedTab.value);
      _subscription = FirestoreService.to.fetchLeaderboard(diff).listen((data) async {
        entries.assignAll(data);
        isLoading.value = false;
        userRank.value = await FirestoreService.to.fetchUserRank(diff);
      });
    }
  }

  Future<void> refreshData() async {
    _fetchEntries();
  }
}
