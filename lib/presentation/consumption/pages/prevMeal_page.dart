import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/consumption/providers/consumption_provider.dart';
import 'package:Fitnessio/presentation/consumption/widgets/meal_widget.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';

class PreviousMealsPage extends StatefulWidget {
  const PreviousMealsPage({super.key});

  @override
  State<PreviousMealsPage> createState() => _PreviousMealsPageState();
}

class _PreviousMealsPageState extends State<PreviousMealsPage> {
  Future<void> _handleRefresh() async {
    setState(() {
      Provider.of<ConsumptionProvider>(context, listen: false)
          .fetchPreviousMeals();
    });

    return await Future.delayed(
      const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Meals'),
        backgroundColor: ColorManager.darkGrey,
      ),
      body: Consumer<ConsumptionProvider>(
        builder: (context, consumptionProvider, _) => SafeArea(
          child: LiquidPullToRefresh(
            height: SizeManager.s250.h,
            color: ColorManager.darkGrey,
            animSpeedFactor: 2,
            backgroundColor: ColorManager.white2,
            onRefresh: _handleRefresh,
            child: FutureBuilder<void>(
              future: consumptionProvider.fetchPreviousMeals(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Failed to load previous meals."),
                  );
                } else if (consumptionProvider.previousMeals.isEmpty) {
                  return const Center(
                    child: Text("No previous meals found."),
                  );
                }

                return ListView.builder(
                  itemCount: consumptionProvider.previousMeals.length,
                  itemBuilder: (context, index) {
                    final meal = consumptionProvider.previousMeals[index];
                    return MealWidget(
                      id: meal.id,
                      title: meal.title,
                      amount: meal.amount,
                      calories: meal.calories,
                      fats: meal.fats,
                      carbs: meal.carbs,
                      proteins: meal.proteins,
                      datetime: meal.dateTime,
                      onPressed: (_) {
                        // setState(() {
                        //   consumptionProvider.deletePreviousMeal(meal.id);
                        // });
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
