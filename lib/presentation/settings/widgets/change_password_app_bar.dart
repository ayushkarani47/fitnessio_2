import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';

class ChangeDataPagesAppBar extends StatelessWidget {
  const ChangeDataPagesAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.darkGrey,
      elevation: SizeManager.s0,
      leading: Padding(
        padding: const EdgeInsets.only(left: PaddingManager.p12),
        child: Container(
          height: SizeManager.s40.h,
          width: SizeManager.s40.w,
          decoration: BoxDecoration(
            color: ColorManager.grey3,
            borderRadius: BorderRadius.circular(
              RadiusManager.r40.r,
            ),
          ),
          child: IconButton(
            splashColor: ColorManager.grey3,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: SizeManager.s26,
              color: ColorManager.white,
            ),
          ),
        ),
      ),
    ).animate().fadeIn(
          duration: 500.ms,
        );
  }
}
