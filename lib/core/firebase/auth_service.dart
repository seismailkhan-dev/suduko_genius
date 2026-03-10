// lib/core/firebase/auth_service.dart

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _user = Rx<User?>(null);

  User? get user => _user.value;
  String? get uid => _user.value?.uid;

  Future<void> init() async {
    _auth.userChanges().listen((user) {
      _user.value = user;
      if (user != null) {
        _saveUserId(user.uid);
      }
    });

    if (_auth.currentUser == null) {
      await signInAnonymously();
    } else {
      _user.value = _auth.currentUser;
    }
  }

  Future<void> signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      _user.value = userCredential.user;
    } catch (e) {
      debugPrint('Firebase Anonymous Sign-In Error: $e');
    }
  }

  Future<void> _saveUserId(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firebase_uid', uid);
  }

  Future<String?> getRecoveredUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('firebase_uid');
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
