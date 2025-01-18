import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:Fitnessio/presentation/consumption/widgets/percent_value_of_meal.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:intl/intl.dart';

class MealWidget extends StatelessWidget {
  const MealWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.calories,
    required this.carbs,
    required this.fats,
    required this.proteins,
    required this.onPressed,
    required this.id,
    required this.datetime,
  });

  final String title;
  final double amount;
  final double calories;
  final double fats;
  final double carbs;
  final double proteins;
  final Function(BuildContext)? onPressed;
  final String id;
  final DateTime datetime;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM dd').format(datetime);
    final formattedTime = DateFormat('hh:mm a').format(datetime);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: PaddingManager.p8.h,
        horizontal: PaddingManager.p16.w,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onPressed,
              icon: Icons.delete,
              label: StringsManager.delete,
              foregroundColor: ColorManager.limerGreen2,
              backgroundColor: ColorManager.darkGrey,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.black87,
            border: Border.all(color: ColorManager.limerGreen2, width: 1.w),
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.all(PaddingManager.p12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Date/Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Row(
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        color: ColorManager.limerGreen2,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        title,
                        style: StyleManager.mealWidgetTitleTextStyle.copyWith(
                          fontSize: 14.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  // Date and Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formattedDate,
                        style: StyleManager.mealWidgetDataTextStyle.copyWith(
                          fontSize: 12.sp,
                          color: ColorManager.lighGrey,
                        ),
                      ),
                      Text(
                        formattedTime,
                        style: StyleManager.mealWidgetDataTextStyle.copyWith(
                          fontSize: 12.sp,
                          color: ColorManager.lighGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Calories and Amount
              Row(
                children: [
                  Text(
                    '🔥 ${calories.round()} kcal',
                    style: StyleManager.mealWidgetDataTextStyle.copyWith(
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    width: 10.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: ColorManager.limerGreen2,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    '${amount.round()} g',
                    style: StyleManager.mealWidgetDataTextStyle.copyWith(
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Fats, Carbs, Proteins
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PercentValueOfMeal(
                    value: fats,
                    amount: amount,
                    title: StringsManager.fats,
                  ),
                  PercentValueOfMeal(
                    value: carbs,
                    amount: amount,
                    title: StringsManager.carbs,
                  ),
                  PercentValueOfMeal(
                    value: proteins,
                    amount: amount,
                    title: StringsManager.proteins,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
