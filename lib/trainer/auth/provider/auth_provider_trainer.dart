import 'package:Fitnessio/trainer/auth/pages/add_trainer_data.dart';
import 'package:Fitnessio/trainer/presentation/trainer_main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';

class AuthProviderTrainer with ChangeNotifier {
  User? _trainer;
  bool? _isNewUser;
  bool? _hasAgeParameter;

  AuthProviderTrainer() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _trainer = user;
      if (_trainer != null) {
        FirebaseFirestore.instance
            .collection('trainers')
            .doc(_trainer!.email)
            .get()
            .then((docSnapshot) {
          _hasAgeParameter =
              docSnapshot.exists && docSnapshot.data()!.containsKey('age');
          _isNewUser = _trainer!.metadata.creationTime ==
                  _trainer!.metadata.lastSignInTime &&
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

  void callAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _trainer = user;
      if (_trainer != null) {
        FirebaseFirestore.instance
            .collection('trainers')
            .doc(_trainer!.email)
            .get()
            .then((docSnapshot) {
          _hasAgeParameter =
              docSnapshot.exists && docSnapshot.data()!.containsKey('age');
          _isNewUser = _trainer!.metadata.creationTime ==
                  _trainer!.metadata.lastSignInTime &&
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

  User? get user => _trainer;
  bool? get isNewUser => _isNewUser;
  bool? get hasAgeParameter => _hasAgeParameter;

  Future<void> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: SpinKitSpinningLines(color: ColorManager.limerGreen2),
            ),
          );
        });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (_) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(PaddingManager.p40),
                child: AlertDialog(
                  backgroundColor: ColorManager.darkGrey,
                  title: Text(
                    StringsManager.success,
                    textAlign: TextAlign.center,
                    style: StyleManager.forgotPWErrorTextStyle,
                  ),
                  content: Text(
                    StringsManager.pwResetLinkSent,
                    textAlign: TextAlign.center,
                    style: StyleManager.forgotPWErrorContentTextStyle,
                  ),
                ),
              ),
            );
          });

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (_) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(PaddingManager.p40),
                child: AlertDialog(
                  backgroundColor: ColorManager.darkGrey,
                  title: Text(
                    StringsManager.wrongEmail,
                    textAlign: TextAlign.center,
                    style: StyleManager.forgotPWErrorTextStyle,
                  ),
                  content: Text(
                    e.message.toString(),
                    textAlign: TextAlign.center,
                    style: StyleManager.forgotPWErrorContentTextStyle,
                  ),
                ),
              ),
            );
          });
    }
  }

  void _showToast(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color ?? Colors.black,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: SpinKitSpinningLines(color: ColorManager.limerGreen2),
            ),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _showToast(context, 'Sign-in successful', color: Colors.green);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      notifyListeners();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TrainerMainPage()));
    } on FirebaseAuthException catch (e) {
      Future.delayed(const Duration(seconds: 2)).then(
        (value) {
          Navigator.pop(context);
          _showToast(context, e.message ?? 'Sign-in failed', color: Colors.red);
          notifyListeners();
        },
      );
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
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
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      await FirebaseFirestore.instance
          .collection('trainers')
          .doc(user!.email)
          .set({});
      _showToast(context, 'Registration successful', color: Colors.green);

      notifyListeners();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AddTrainerDataPage()));
    } on FirebaseAuthException catch (e) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.pop(context);
        _showToast(context, e.message ?? 'Registration failed',
            color: Colors.red);
        notifyListeners();
      });
    }
  }

  Future<void> addUserData({
    required String email,
    required String name,
    required String surname,
    required int age,
    required double height,
    required double weight,
    required String gender,
    required int expInYears,
    required BuildContext context,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('trainers')
          .doc(user!.email)
          .update({
        'email': email,
        'name': name,
        'surname': surname,
        'age': age,
        'height': height,
        'weight': weight,
        'gender': gender,
        'expInYears': expInYears,
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

 Future<List<Map<String, dynamic>>> fetchUsersForTrainer() async {
  String trainerEmail = FirebaseAuth.instance.currentUser!.email!;
  try {
    //Get current user email id
    
    // Reference the trainer's document in the 'trainers' collection
    CollectionReference usersCollection = FirebaseFirestore.instance
        .collection('trainers')
        .doc(trainerEmail)
        .collection('users');

    // Fetch all documents (users) in the trainer's subcollection
    QuerySnapshot querySnapshot = await usersCollection.get();

    // Map the documents to a list of user data
    List<Map<String, dynamic>> users = querySnapshot.docs.map((doc) {
      return {
        'id': doc.id, // Document ID (user ID)
        ...doc.data() as Map<String, dynamic>, // User data
      };
    }).toList();

    return users; // Return the list of users
  } catch (e) {
    print('Error fetching users for trainer $trainerEmail: $e');
    return []; // Return an empty list in case of error
  }
}
}
