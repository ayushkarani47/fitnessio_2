import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Fitnessio/model/meal_model.dart';
import 'package:Fitnessio/model/water_model.dart';

class ConsumptionProvider with ChangeNotifier {
  final List<MealModel> _meals = [];
  final List<WaterModel> _water = [];
  double kCalaDay = 0.0;
  double waterADay = 0.0;

  List<MealModel> get meals {
    return [..._meals];
  }

  List<WaterModel> get water {
    return [..._water];
  }

  Future<void> addNewMeal({
    required String title,
    required double amount,
    required double calories,
    required double fats,
    required double carbs,
    required double proteins,
    required DateTime dateTime,
    required String mealType, // Add this
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('meals')
          .doc(user!.uid)
          .collection('mealData')
          .doc()
          .set({
        'title': title,
        'amount': amount,
        'calories': calories,
        'fats': fats,
        'carbs': carbs,
        'proteins': proteins,
        'dateTime': dateTime,
        'mealType': mealType, // Add this field
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, List<MealModel>>> fetchAndSetMeals() async {
  User? user = FirebaseAuth.instance.currentUser;

  try {
    // Fetch all meals for the user
    final mealsSnapshot = await FirebaseFirestore.instance
        .collection('meals')
        .doc(user!.uid)
        .collection('mealData')
        .orderBy('dateTime')
        .get();

    //print(mealsSnapshot.docs);

    // Initialize categorized meals
    Map<String, List<MealModel>> categorizedMeals = {
      'breakfast': [],
      'lunch': [],
      'evening snacks': [],
      'dinner': [],
    };

    for (var doc in mealsSnapshot.docs) {
      final mealData = doc.data();
      String mealType = (mealData['mealType'] ?? 'other').toLowerCase(); // Normalize to lowercase
     // print("Processing meal: ${mealData['title']} of type $mealType");

      MealModel meal = MealModel(
        id: doc.id,
        title: mealData['title'],
        amount: mealData['amount'],
        calories: mealData['calories'],
        fats: mealData['fats'],
        carbs: mealData['carbs'],
        proteins: mealData['proteins'],
        mealType: mealType,
        dateTime: (mealData['dateTime'] as Timestamp).toDate(),
      );

      if (categorizedMeals.containsKey(mealType)) {
        categorizedMeals[mealType]?.add(meal);
      }
    }

    print(categorizedMeals); // Print categorized meals to verify
    return categorizedMeals;
  } catch (e) {
    rethrow;
  }
}


  Future<List<MealModel>> fetchPreviousMeals() async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      // Get today's date at midnight
      DateTime today = DateTime.now();
      DateTime todayMidnight = DateTime(today.year, today.month, today.day);

      // Query Firestore for meals before today
      final mealsSnapshot = await FirebaseFirestore.instance
          .collection('meals')
          .doc(user!.uid)
          .collection('mealData')
          .where('dateTime', isLessThan: todayMidnight)
          .get();

      // Parse the fetched data into a list of MealModel objects
      final List<MealModel> previousMeals = [];
      for (var doc in mealsSnapshot.docs) {
        final mealData = doc.data();
        previousMeals.add(MealModel(
          id: doc.id,
          title: mealData['title'],
          amount: mealData['amount'],
          calories: mealData['calories'],
          fats: mealData['fats'],
          carbs: mealData['carbs'],
          proteins: mealData['proteins'],
          mealType: mealData['mealType'],
          dateTime: (mealData['dateTime'] as Timestamp).toDate(),
        ));
      }

      return previousMeals;
    } catch (e) {
      rethrow;
    }
  }

  List<MealModel> get previousMeals {
    return _meals.where((meal) {
      DateTime today = DateTime.now();
      DateTime todayMidnight = DateTime(today.year, today.month, today.day);
      return meal.dateTime.isBefore(todayMidnight);
    }).toList();
  }

  getkCal() async {
    kCalaDay = 0.0;
    for (var meal in _meals) {
      kCalaDay += meal.calories;
    }
    notifyListeners();
  }

  // Future<void> clearMealsIfDayChanges(DateTime lastDateTime) async {
  //   DateTime now = DateTime.now();

  //   if (isLastDateTimeDifferent(now, lastDateTime)) {
  //     try {
  //       User? user = FirebaseAuth.instance.currentUser;

  //       await FirebaseFirestore.instance
  //           .collection('meals')
  //           .doc(user!.uid)
  //           .collection('mealData')
  //           .get()
  //           .then((querySnapshot) {
  //         for (var doc in querySnapshot.docs) {
  //           DateTime mealDateTime = (doc['dateTime'] as Timestamp).toDate();
  //           if (isInputTimeDifferent(now, mealDateTime)) {
  //             doc.reference.delete();
  //           }
  //         }
  //       });
  //     } catch (e) {
  //       rethrow;
  //     }
  //   }
  // }

  bool isLastDateTimeDifferent(DateTime now, DateTime lastDateTime) {
    return now.year != lastDateTime.year ||
        now.month != lastDateTime.month ||
        now.day != lastDateTime.day;
  }

  bool isInputTimeDifferent(DateTime now, DateTime inputDateTime) {
    return now.year != inputDateTime.year ||
        now.month != inputDateTime.month ||
        now.day != inputDateTime.day;
  }

  Future<void> addWater({
    required double amount,
    required DateTime dateTime,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('meals')
          .doc(user!.uid)
          .collection('waterData')
          .doc()
          .set({
        'amount': amount,
        'dateTime': dateTime,
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future fetchAndSetWater() async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      final mealsSnapshot = await FirebaseFirestore.instance
          .collection('meals')
          .doc(user!.uid)
          .collection('waterData')
          .get();

      final List<WaterModel> loadedWater = [];

      for (var doc in mealsSnapshot.docs) {
        final mealData = doc.data();
        loadedWater.add(WaterModel(
          id: doc.id,
          amount: mealData['amount'],
          dateTime: (mealData['dateTime'] as Timestamp).toDate(),
        ));
      }
      _water.clear();
      _water.addAll(loadedWater);
      await getWater();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  getWater() async {
    waterADay = 0.0;
    for (var water in _water) {
      waterADay += water.amount;
    }
    notifyListeners();
  }

  Future<void> clearWaterIfDayChanges(DateTime lastDateTime) async {
    DateTime now = DateTime.now();

    if (isLastDateTimeDifferent(now, lastDateTime)) {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance
            .collection('meals')
            .doc(user!.uid)
            .collection('waterData')
            .get()
            .then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            DateTime waterDateTime = (doc['dateTime'] as Timestamp).toDate();
            if (isInputTimeDifferent(now, waterDateTime)) {
              doc.reference.delete();
            }
          }
        });
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> deleteMeal(String mealID) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('meals')
          .doc(user!.uid)
          .collection('mealData')
          .doc(mealID)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
  Future<void> addNewMealTrainer({
    required String title,
    required double amount,
    required double calories,
    required double fats,
    required double carbs,
    required double proteins,
    required DateTime dateTime,
    required String mealType, // Add this
    required String userId,
  }) async {
    try {
      //User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('meals')
          .doc(userId)
          .collection('mealData')
          .doc()
          .set({
        'title': title,
        'amount': amount,
        'calories': calories,
        'fats': fats,
        'carbs': carbs,
        'proteins': proteins,
        'dateTime': dateTime,
        'mealType': mealType, // Add this field
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

 Future<Map<String, List<MealModel>>> fetchAndSetMealsTrainer(String userId) async {
  print("Fetching meals for user: $userId");
  try {
    final mealsSnapshot = await FirebaseFirestore.instance
        .collection('meals')
        .doc(userId)
        .collection('mealData')
        .orderBy('dateTime')
        .get();

    print("Meals snapshot fetched: ${mealsSnapshot.docs.length} docs");

    if (mealsSnapshot.docs.isEmpty) {
      print("No meals found for user: $userId");
    }

    Map<String, List<MealModel>> categorizedMeals = {
      'breakfast': [],
      'lunch': [],
      'evening snacks': [],
      'dinner': [],
    };

    for (var doc in mealsSnapshot.docs) {
      final mealData = doc.data();
      print("Meal data: $mealData");
      
      String mealType = (mealData['mealType'] ?? 'other').toLowerCase();
      print("Meal type: $mealType");

      // Check for missing fields before creating MealModel
      if (mealData['title'] == null || mealData['amount'] == null) {
        print("Missing required fields for meal: ${doc.id}");
        continue; // Skip this document
      }

      MealModel meal = MealModel(
        id: doc.id,
        title: mealData['title'],
        amount: mealData['amount'],
        calories: mealData['calories'],
        fats: mealData['fats'],
        carbs: mealData['carbs'],
        proteins: mealData['proteins'],
        mealType: mealType,
        dateTime: (mealData['dateTime'] as Timestamp).toDate(),
      );

      if (categorizedMeals.containsKey(mealType)) {
        categorizedMeals[mealType]?.add(meal);
      }
    }

    print("Categorized meals: $categorizedMeals");
    return categorizedMeals;
  } catch (e) {
    print("Error fetching meals: $e");
    rethrow;
  }
}

}
