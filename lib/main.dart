import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'core/firebase/auth_service.dart';
import 'core/firebase/firestore_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase FIRST
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register services immediately 
  Get.put(AuthService());
  Get.put(FirestoreService());

  runApp(const App());
}
