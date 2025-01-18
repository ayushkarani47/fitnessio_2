import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/font_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';

class QuickWaterAddButton extends StatelessWidget {
  const QuickWaterAddButton({
    super.key,
    required this.label,
    required this.addWater,
  });
  final String label;
  final VoidCallback addWater;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addWater,
      child: Container(
        height: SizeManager.s50.h,
        width: SizeManager.s100.w,
        decoration: BoxDecoration(
          color: ColorManager.grey3,
          borderRadius: BorderRadius.circular(
            RadiusManager.r15.r,
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorManager.white,
              fontSize: FontSize.s20,
              fontWeight: FontWightManager.semiBold,
              letterSpacing: SizeManager.s1_5,
            ),
          ),
        ),
      ),
    );
  }
}
