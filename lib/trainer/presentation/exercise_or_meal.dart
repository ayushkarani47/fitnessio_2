
import 'package:Fitnessio/trainer/presentation/consuption_trainer_page.dart';
import 'package:Fitnessio/trainer/presentation/exercise_page.dart';
import 'package:flutter/material.dart';

class ExerciseOrMeal extends StatelessWidget {
  final Map<String, dynamic> user;

  const ExerciseOrMeal({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    String userid = user['id'];
    print('User ID: $userid');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Choose an Option',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Exercise Container
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                // Navigate to Exercise Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExercisePage(user: user),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Exercise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Meal Container
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                // Navigate to Meal Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsuptionTrainerPage(user: user,),
                  ),
                );
              },
              child: Container(
                //height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Meal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
