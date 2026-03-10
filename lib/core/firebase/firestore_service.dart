// lib/core/firebase/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../puzzle/models.dart';
import 'auth_service.dart';

class LeaderboardEntry {
  final String userId;
  final String displayName;
  final int score; // totalXP or time
  final int level;
  final int puzzlesSolved;
  final DateTime updatedAt;

  LeaderboardEntry({
    required this.userId,
    required this.displayName,
    required this.score,
    this.level = 1,
    this.puzzlesSolved = 0,
    required this.updatedAt,
  });

  factory LeaderboardEntry.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LeaderboardEntry(
      userId: doc.id,
      displayName: data['displayName'] ?? 'Guest',
      score: data['totalXP'] ?? data['timeTaken'] ?? 0,
      level: data['level'] ?? 1,
      puzzlesSolved: data['puzzlesSolved'] ?? 0,
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }
}

class FirestoreService extends GetxService {
  static FirestoreService get to => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── Push Methods ──────────────────────────────────────────────────────────

  Future<void> pushLeaderboardScore(Difficulty diff, GameResult result) async {
    final uid = AuthService.to.uid;
    if (uid == null) return;

    final docRef = _db.collection('leaderboard').doc(diff.name).collection('scores').doc(uid);

    await _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      
      if (!snapshot.exists) {
        transaction.set(docRef, {
          'displayName': 'Guest Player',
          'totalXP': result.xpEarned,
          'level': 1,
          'bestTime': result.elapsed.inSeconds,
          'puzzlesSolved': 1,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        final data = snapshot.data()!;
        final newXP = (data['totalXP'] ?? 0) + result.xpEarned;
        final oldBest = data['bestTime'] ?? 999999;
        final newBest = result.elapsed.inSeconds < oldBest ? result.elapsed.inSeconds : oldBest;
        
        transaction.update(docRef, {
          'totalXP': newXP,
          'level': (newXP / 1000).floor() + 1,
          'bestTime': newBest,
          'puzzlesSolved': (data['puzzlesSolved'] ?? 0) + 1,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  Future<void> pushDailyResult(String date, GameResult result) async {
    final uid = AuthService.to.uid;
    if (uid == null) return;

    final docRef = _db.collection('daily_leaderboard').doc(date).collection('scores').doc(uid);

    await docRef.set({
      'displayName': 'Guest Player',
      'timeTaken': result.elapsed.inSeconds,
      'mistakes': result.mistakes,
      'hintsUsed': result.hintsUsed,
      'completedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> pushEventResult(String eventId, int trophies, int puzzles) async {
    final uid = AuthService.to.uid;
    if (uid == null) return;

    final docRef = _db.collection('events').doc(eventId).collection('results').doc(uid);

    await docRef.set({
      'trophiesEarned': trophies,
      'puzzlesDone': puzzles,
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // ── Fetch Methods ─────────────────────────────────────────────────────────

  Stream<List<LeaderboardEntry>> fetchLeaderboard(Difficulty diff) {
    return _db
        .collection('leaderboard')
        .doc(diff.name)
        .collection('scores')
        .orderBy('totalXP', descending: true)
        .limit(100)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => LeaderboardEntry.fromFirestore(doc)).toList());
  }

  Stream<List<LeaderboardEntry>> fetchDailyLeaderboard(String date) {
    return _db
        .collection('daily_leaderboard')
        .doc(date)
        .collection('scores')
        .orderBy('timeTaken', descending: false)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => LeaderboardEntry.fromFirestore(doc)).toList());
  }

  Future<int> fetchUserRank(Difficulty diff) async {
    final uid = AuthService.to.uid;
    if (uid == null) return -1;

    final userDoc = await _db.collection('leaderboard').doc(diff.name).collection('scores').doc(uid).get();
    if (!userDoc.exists) return -1;

    final userXP = userDoc.data()?['totalXP'] ?? 0;
    
    final countSnapshot = await _db
        .collection('leaderboard')
        .doc(diff.name)
        .collection('scores')
        .where('totalXP', isGreaterThan: userXP)
        .count()
        .get();
        
    return countSnapshot.count! + 1;
  }
}
