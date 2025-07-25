import 'package:Fitnessio/app/app.dart';
import 'package:Fitnessio/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
 //import 'package:smart_home_app/app/app.dart';
// import 'package:smart_home_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if Firebase is already initialized before initializing
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: "fitnessio-4bb4c",
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Fitness Project connecteddddd");
  } else {
    print("Firebase is already initialized");
  }

  runApp(MyApp());
}
