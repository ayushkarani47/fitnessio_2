import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewExerciseButton extends StatelessWidget {
  const NewExerciseButton({
    required this.onTap,
    super.key,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
        top: PaddingManager.p28,
        bottom: PaddingManager.p12,
        right: PaddingManager.p12,
        left: PaddingManager.p12,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: deviceWidth,
          height: SizeManager.s60.h,
          decoration: BoxDecoration(
            color: ColorManager.limerGreen2,
            borderRadius: BorderRadius.circular(
              RadiusManager.r15.r,
            ),
          ),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.newExercise,
              //StringsManager.newExercise,
              textAlign: TextAlign.center,
              style: StyleManager.newExerciseButtonTextSTyle,
            ),
          ),
        ),
      ),
    );
  }
}
