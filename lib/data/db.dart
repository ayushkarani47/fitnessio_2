import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final String uid;

  DataBase(this.uid);
  final CollectionReference trainerCollection =
      FirebaseFirestore.instance.collection('trainers');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference mealCollection =
      FirebaseFirestore.instance.collection('meals');
  Future<void> deleteUserData() {
    return userCollection.doc(uid).delete();
  }

  Future<void> deleteMealData() {
    return mealCollection.doc(uid).delete();
  }
}
