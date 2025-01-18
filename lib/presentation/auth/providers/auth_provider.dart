import 'package:Fitnessio/presentation/auth/pages/add_data_page.dart';
import 'package:Fitnessio/presentation/main/pages/main_page.dart';
import 'package:Fitnessio/trainer/presentation/trainer_main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool? _hasAgeParameter;
  User? get user => _user;
  bool? get hasAgeParameter => _hasAgeParameter;
  
  bool? _isNewUser;
  String? _trainerEmail;

  // Constructor that accepts trainerEmail
  AuthProvider() {
    _trainerEmail = trainerEmail;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      print("User is this : $_user");
      if (_user != null) {
        FirebaseFirestore.instance
            .collection('trainers')
            .doc(_trainerEmail) // Use the stored trainer email
            .collection('users')
            .doc(_user!.uid)
            .get()
            .then((docSnapshot) {
          _hasAgeParameter =
              docSnapshot.exists && docSnapshot.data()!.containsKey('age');
          _isNewUser =
              _user!.metadata.creationTime == _user!.metadata.lastSignInTime &&
                  !_hasAgeParameter!;
          notifyListeners();
        });
      } else {
        _hasAgeParameter = null;
        _isNewUser = null;
        notifyListeners();
      }
    });
  }

  // Validate trainerEmail before making Firestore calls
  void _validateTrainerEmail(BuildContext context) {
    if (_trainerEmail == null || _trainerEmail!.isEmpty) {
     // _showToast(context, 'Trainer email not set.', color: Colors.red);
      return;
    }
  }

  // Define the callAuth method
  Future<void> callAuth({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _showToast(context, 'Signed in successfully', color: Colors.green);
    } catch (e) {
      _showToast(context, 'Sign-in failed: $e', color: Colors.red);
    }
  }

  // Setter for trainerEmail
  void setTrainerEmail(String trainerEmail) {
    _trainerEmail = trainerEmail;
    notifyListeners();
  }
  
  String? get trainerEmail => _trainerEmail;

  Future<void> register({
    required String email,
    required String password,
    required BuildContext context,
    required String trainerEmail,
    required String trainersPassword,
  }) async {
    _validateTrainerEmail(context); // Ensure trainerEmail is set

    showDialog(
      context: context,
      builder: (_) => Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: SpinKitSpinningLines(color: ColorManager.limerGreen2),
        ),
      ),
    );

    try {
      // Save the current trainer's credentials
      User? currentTrainer = FirebaseAuth.instance.currentUser;
      String? trainerEmail = currentTrainer?.email;
      String? trainerPassword =
          trainersPassword; // Replace with secure password handling.

      // Register the new user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String userId = userCredential.user!.uid;

     

      // Add user data to Firestore
      DocumentReference trainerDocRef =
          FirebaseFirestore.instance.collection('trainers').doc(trainerEmail);

      await trainerDocRef.set({
        'trainerEmail': trainerEmail,
      }, SetOptions(merge: true));

      await trainerDocRef.collection('users').doc(userId).set({
        'userId': userId,
        'email': email,
        'trainerEmail': trainerEmail,
        'registeredAt': FieldValue.serverTimestamp(),
      });

      _showToast(context, 'Registration successful', color: Colors.green);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddDataPage(
                    trainerEmail: trainerEmail!,
                    trainerPassword: trainerPassword,
                  )));
    } catch (e) {
      Navigator.pop(context);
      _showToast(context, 'Registration failed: $e', color: Colors.red);
    }
  }

  // Method to sign in a user
  Future<void> signIn({
    required String email,
    required String password,
    required String trainerEmail,
    required BuildContext context,
  }) async {
    _validateTrainerEmail(context); // Ensure trainerEmail is set

    showDialog(
      context: context,
      builder: (_) => Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: SpinKitSpinningLines(color: ColorManager.limerGreen2),
        ),
      ),
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      String userId = userCredential.user!.uid;

      DocumentSnapshot userDocSnapshot = await FirebaseFirestore.instance
          .collection('trainers')
          .doc(trainerEmail)
          .collection('users')
          .doc(userId)
          .get();

      if (userDocSnapshot.exists) {
        _trainerEmail = userDocSnapshot['trainerEmail'];
      }

      _showToast(context, 'Sign-in successful', color: Colors.green);
      notifyListeners();
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage())); // Navigate to the home page
    } catch (e) {
      Navigator.pop(context);
      _showToast(context, 'Sign-in failed: $e', color: Colors.red);
    }
  }

  // Method to add user data
  Future<void> addUserData({
    required String email,
    required String name,
    required String surname,
    required int age,
    required double height,
    required double weight,
    required String gender,
    required String activity,
    required double bmr,
    required String goal,
    required double bmi,
    required BuildContext context,
    required String trainerEmail,
    required String trainerPassword,
  }) async {
    _validateTrainerEmail(context); // Ensure trainerEmail is set

    // User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _showToast(context, 'User not authenticated. Please sign in again.',
          color: Colors.red);
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc(trainerEmail)
          .collection('users')
          .doc(user!.uid)
          .update({
        'email': email,
        'name': name,
        'surname': surname,
        'age': age,
        'height': height,
        'weight': weight,
        'gender': gender,
        'activity': activity,
        'bmr': bmr,
        'goal': goal,
        'bmi': bmi,
        'chest': 0.0,
        'shoulders': 0.0,
        'biceps': 0.0,
        'foreArm': 0.0,
        'waist': 0.0,
        'hips': 0.0,
        'thigh': 0.0,
        'calf': 0.0,
      });
 // Sign the trainer back in
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: trainerEmail,
        password: trainerPassword,
      );
          _showToast(context, 'User data added successfully', color: Colors.green);
      notifyListeners();
    } catch (e) {
      _showToast(context, 'Unexpected error: $e', color: Colors.red);
    }
  }

  // Helper method to show toast messages
  void _showToast(BuildContext context, String message,
      {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  // Forgot password method
  Future<void> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showToast(context, 'Password reset email sent.', color: Colors.green);
    } catch (e) {
      _showToast(context, 'Failed to send reset email: $e', color: Colors.red);
    }
  }
}
