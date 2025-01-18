import 'package:Fitnessio/model/meal_model.dart';
import 'package:Fitnessio/presentation/consumption/pages/prevMeal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/consumption/providers/consumption_provider.dart';
import 'package:Fitnessio/presentation/consumption/widgets/meal_widget.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/router/router.dart';

class ConsumptionPage extends StatefulWidget {
  const ConsumptionPage({super.key});

  @override
  State<ConsumptionPage> createState() => _ConsumptionPageState();
}

class _ConsumptionPageState extends State<ConsumptionPage> {
  Future<void> _handleRefresh() async {
    await Provider.of<ConsumptionProvider>(context, listen: false)
        .fetchAndSetMeals();
    setState(() {
      
    }); // Ensure UI is refreshed
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConsumptionProvider>(
      builder: (context, consumptionProvider, _) {
        return SafeArea(
          child: LiquidPullToRefresh(
            height: SizeManager.s250.h,
            color: ColorManager.darkGrey,
            animSpeedFactor: 2,
            backgroundColor: ColorManager.white2,
            onRefresh: _handleRefresh,
            child: FutureBuilder<Map<String, List<MealModel>>>(
              future: consumptionProvider.fetchAndSetMeals(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final categorizedMeals = snapshot.data!;
                  return ListView(
                    children: categorizedMeals.entries.map((entry) {
                      final category = entry.key;
                      final meals = entry.value;

                      return meals.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(PaddingManager.p12),
                                  child: Text(
                                    category.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: ColorManager.darkGrey,
                                        ),
                                  ),
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: meals.length,
                                  itemBuilder: (context, index) {
                                    final meal = meals[index];
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
                                        setState(() {
                                          consumptionProvider.deleteMeal(meal.id);
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            );
                    }).toList(),
                  );
                } else {
                  return const Center(child: Text('No meals available.'));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
