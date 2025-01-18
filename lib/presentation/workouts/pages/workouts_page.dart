import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/workouts/providers/workout_provider.dart';
import 'package:Fitnessio/presentation/workouts/widgets/exercise_widget.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';

class WorkoutPage extends StatefulWidget {
  User? user = FirebaseAuth.instance.currentUser;
   WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Future<void> _handleRefresh() async {
    setState(() {
      Provider.of<WorkoutProvider>(context, listen: false)
          .fetchAndSetWorkouts(widget.user);
    });
    return await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutsProvider, _) => SafeArea(
        child: LiquidPullToRefresh(
          height: SizeManager.s250.h,
          color: ColorManager.darkGrey,
          animSpeedFactor: 2,
          backgroundColor: ColorManager.white2,
          onRefresh: _handleRefresh,
          child: FutureBuilder<void>(
            future: workoutsProvider.fetchAndSetWorkouts(widget.user),
            builder: (context, snapshot) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Align(
                      //   alignment: Alignment.topCenter,
                      //   child: NewExerciseButton(
                      //     onTap: () {
                      //       Navigator.of(context).pushNamed(
                      //         Routes.addNewExerciseRoute,
                      //       );
                      //     },
                      //   ),
                      // ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: workoutsProvider.workouts.length,
                          itemBuilder: (context, index) {
                            final workout = workoutsProvider.workouts[index];
                            final allWorkouts =
                                workoutsProvider.allWorkouts[index];
                            return ExerciseWidget(
                              name: workout.name,
                              repNumber: workout.repNumber,
                              setNumber: workout.setNumber,
                              id: workout.id,
                              datetime: workout.dateTime,
                              onDeleted: (_) {
                                setState(
                                  () {
                                    workoutsProvider.deleteWorkout(
                                      workoutID: workout.id,
                                    );
                                    workoutsProvider.deleteAllWorkout(
                                      allWorkoutID: allWorkouts.id,
                                    );
                                  },
                                );
                              },
                              onFinished: (_) {
                                setState(
                                  () {
                                    workoutsProvider.finishWorkout(
                                      workoutID: workout.id,
                                      name: workout.name,
                                      repNumber: workout.repNumber,
                                      setNumber: workout.setNumber,
                                      dateTime: workout.dateTime,
                                    );
                                    workoutsProvider.deleteWorkout(
                                      workoutID: workout.id,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
