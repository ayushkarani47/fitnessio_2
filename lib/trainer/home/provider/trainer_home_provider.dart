import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TrainerHomeProvider with ChangeNotifier {
  final Map<String, dynamic> _trainerData = {};

  Future<Map<String, dynamic>> fetchTrainerData() async {
    try {
      User? trainer = FirebaseAuth.instance.currentUser;

      if (trainer != null) {
        DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
            .collection('trainers')
            .doc(trainer.email)
            .get();
        _trainerData['name'] = userDataSnapshot.get('name');
        _trainerData['surname'] = userDataSnapshot.get('surname');
        _trainerData['age'] = userDataSnapshot.get('age');
        _trainerData['height'] = userDataSnapshot.get('height');
        _trainerData['weight'] = userDataSnapshot.get('weight');
        _trainerData['gender'] = userDataSnapshot.get('gender');
        _trainerData['email'] = userDataSnapshot.get('email');
        _trainerData['expInYears'] = userDataSnapshot.get('expInYears');

        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
    return _trainerData;
  }

  Map<String, dynamic> get userData => _trainerData;
}
