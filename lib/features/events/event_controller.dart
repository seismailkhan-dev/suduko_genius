// lib/features/events/event_controller.dart

import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' as drift;
import 'package:get/get.dart';
import '../../../core/firebase/firestore_service.dart';

import '../../core/db/app_database.dart';
import '../../core/db/db_service.dart';
import 'event_model.dart';

class EventController extends GetxController {
  final activeEvent = Rx<Event?>(null);
  final trophiesEarned = 0.obs;
  final puzzlesDone = 0.obs;
  final countdownString = '00:00:00'.obs;
  final milestoneStatuses = <bool>[].obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _fetchAndLoadEvent();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> _fetchAndLoadEvent() async {
    // 1. Stubbed remote config fetch.
    // In production: FirebaseRemoteConfig.instance.getString('active_event_json');
    const mockJson = '''
    {
      "id": "spring_tourney_26",
      "name": "Spring Tournament",
      "description": "Complete puzzles to earn spring trophies and unlock exclusive rewards!",
      "startDate": "2026-03-01T00:00:00Z",
      "endDate": "2026-03-31T23:59:59Z",
      "trophyImageUrl": "https://example.com/trophy",
      "milestones": [
        {"trophiesRequired": 5, "rewardName": "Beginner Badge", "rewardIcon": "🥉"},
        {"trophiesRequired": 15, "rewardName": "Silver Ticket", "rewardIcon": "🥈"},
        {"trophiesRequired": 30, "rewardName": "Golden Theme", "rewardIcon": "🥇"},
        {"trophiesRequired": 50, "rewardName": "Diamond Avatar", "rewardIcon": "💎"}
      ]
    }
    ''';

    try {
      final jsonMap = jsonDecode(mockJson) as Map<String, dynamic>;
      final event = Event.fromJson(jsonMap);

      final now = DateTime.now();
      if (now.isAfter(event.startDate) && now.isBefore(event.endDate)) {
        activeEvent.value = event;
        await _loadProgressFromDrift(event.id);
        _startCountdown(event.endDate);
      } else {
        activeEvent.value = null; // Event elapsed or not started
      }
    } catch (_) {
      // JSON parse error or invalid format
      activeEvent.value = null;
    }
  }

  Future<void> _loadProgressFromDrift(String eventId) async {
    final db = DbService.instance;
    final progress = await db.events.getByEventId(eventId);

    if (progress != null) {
      trophiesEarned.value = progress.trophiesEarned;
      puzzlesDone.value = progress.puzzlesDone;
      
      try {
        final claimed = (jsonDecode(progress.claimedMilestonesJson) as List).cast<int>();
        _recalculateMilestoneArray(claimed);
      } catch (_) {
        _recalculateMilestoneArray([]);
      }
    } else {
      trophiesEarned.value = 0;
      puzzlesDone.value = 0;
      _recalculateMilestoneArray([]);
    }
  }

  void _recalculateMilestoneArray(List<int> claimedIndices) {
    if (activeEvent.value == null) return;
    
    final length = activeEvent.value!.milestones.length;
    final statuses = List<bool>.filled(length, false);
    for (final i in claimedIndices) {
      if (i >= 0 && i < length) statuses[i] = true;
    }
    milestoneStatuses.assignAll(statuses);
  }

  void _startCountdown(DateTime endDate) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      if (now.isAfter(endDate)) {
        activeEvent.value = null;
        _timer?.cancel();
        return;
      }
      
      final diff = endDate.difference(now);
      final d = diff.inDays > 0 ? '${diff.inDays}d ' : '';
      final h = (diff.inHours % 24).toString().padLeft(2, '0');
      final m = (diff.inMinutes % 60).toString().padLeft(2, '0');
      final s = (diff.inSeconds % 60).toString().padLeft(2, '0');
      
      countdownString.value = '$d$h:$m:$s';
    });
  }

  /// Triggers whenever a puzzle is completed. Rewards 1 trophy.
  Future<void> onPuzzleComplete() async {
    final ev = activeEvent.value;
    if (ev == null) return;

    trophiesEarned.value += 1;
    puzzlesDone.value += 1;

    final db = DbService.instance;
    
    // Get existing to find claimed milestones
    final existing = await db.events.getByEventId(ev.id);
    final claimedJson = existing?.claimedMilestonesJson ?? '[]';

    final now = DateTime.now().toIso8601String();
    
    await db.events.upsert(EventProgressCompanion.insert(
      eventId: ev.id,
      trophiesEarned: drift.Value(trophiesEarned.value),
      puzzlesDone: drift.Value(puzzlesDone.value),
      claimedMilestonesJson: drift.Value(claimedJson), // keeps existing claims
      updatedAt: drift.Value(now),
    ));

    // Push to Firestore Event Progress
    try {
      if (Get.isRegistered<FirestoreService>()) {
        await Get.find<FirestoreService>().pushEventResult(ev.id, trophiesEarned.value, puzzlesDone.value);
      }
    } catch (_) {}
    
    // In production, sync to Firestore / remote leaderboard here.
  }

  /// Marks a specific milestone as claimed by its index.
  Future<void> claimMilestone(int index) async {
    final ev = activeEvent.value;
    if (ev == null) return;

    final ms = ev.milestones[index];
    if (trophiesEarned.value < ms.trophiesRequired) return; // not unlocked
    if (milestoneStatuses[index]) return; // already claimed

    milestoneStatuses[index] = true; // render UI immediately

    // Persist to Drift natively
    final db = DbService.instance;
    final existing = await db.events.getByEventId(ev.id);
    List<int> claimed = [];
    if (existing != null) {
      try {
        claimed = (jsonDecode(existing.claimedMilestonesJson) as List).cast<int>();
      } catch (_) {}
    }
    
    if (!claimed.contains(index)) {
      claimed.add(index);
    }
    
    final claimedJson = jsonEncode(claimed);
    final now = DateTime.now().toIso8601String();

    await db.events.upsert(EventProgressCompanion.insert(
      eventId: ev.id,
      trophiesEarned: drift.Value(trophiesEarned.value), // copy current
      puzzlesDone: drift.Value(puzzlesDone.value),  // copy current
      claimedMilestonesJson: drift.Value(claimedJson),
      updatedAt: drift.Value(now),
    ));
  }
}
