import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:intl/intl.dart';

class ExerciseWidget extends StatelessWidget {
  const ExerciseWidget({
    super.key,
    required this.name,
    required this.repNumber,
    required this.setNumber,
    required this.onDeleted,
    required this.onFinished,
    required this.id,
    required this.datetime, // DateTime field
  });

  final String name;
  final int setNumber;
  final int repNumber;
  final Function(BuildContext)? onDeleted;
  final Function(BuildContext)? onFinished;
  final String id;
  final DateTime datetime;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final formattedDate = DateFormat('MMM dd').format(datetime);
    final formattedTime = DateFormat('hh:mm a').format(datetime);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: PaddingManager.p8.h,
        horizontal: PaddingManager.p16.w,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onFinished,
              icon: Icons.done_all_sharp,
              label: StringsManager.finished,
              foregroundColor: ColorManager.darkGrey,
              backgroundColor: ColorManager.limerGreen2,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDeleted,
              icon: Icons.delete,
              label: StringsManager.delete,
              foregroundColor: ColorManager.limerGreen2,
              backgroundColor: ColorManager.darkGrey,
            ),
          ],
        ),
        child: Container(
          width: deviceWidth,
          height: 120.h, // Adjusted for responsiveness
          decoration: BoxDecoration(
            color: ColorManager.black87,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: ColorManager.limerGreen2,
              width: 1.w,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(PaddingManager.p12.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Exercise Name
                    Flexible(
                      child: Text(
                        name,
                        style: StyleManager.exerciseNameTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Date and Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formattedDate,
                          style: StyleManager.exerciseRepAndSetHintTextStyle
                              .copyWith(color: ColorManager.lighGrey),
                        ),
                        Text(
                          formattedTime,
                          style: StyleManager.exerciseRepAndSetHintTextStyle
                              .copyWith(color: ColorManager.lighGrey),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: SizeManager.s10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Set Number
                    Row(
                      children: [
                        Text(
                          '${setNumber.round()}',
                          style: StyleManager.exerciseRepAndSetNumberTextStyle,
                        ),
                        SizedBox(width: SizeManager.s5.w),
                        Text(
                          StringsManager.setNumberHint,
                          style: StyleManager.exerciseRepAndSetHintTextStyle,
                        ),
                      ],
                    ),
                    // Rep Number
                    Row(
                      children: [
                        Text(
                          '${repNumber.round()}',
                          style: StyleManager.exerciseRepAndSetNumberTextStyle,
                        ),
                        SizedBox(width: SizeManager.s5.w),
                        Text(
                          StringsManager.repNumberHint,
                          style: StyleManager.exerciseRepAndSetHintTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
