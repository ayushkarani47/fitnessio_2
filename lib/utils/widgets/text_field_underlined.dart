import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/font_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';

class TextFieldWidgetUnderLined extends StatelessWidget {
  const TextFieldWidgetUnderLined({
    super.key,
    required this.controller,
    required this.labelHint,
    required this.obscureText,
    required this.keyboardType, required bool readOnly,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String labelHint;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth,
      height: SizeManager.s50.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorManager.limerGreen2,
            width: SizeManager.s0_7.h,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(PaddingManager.p8),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: ColorManager.white,
            fontWeight: FontWightManager.bold,
          ),
          autocorrect: false,
          keyboardType: keyboardType,
          cursorColor: ColorManager.white,
          decoration: InputDecoration(
            labelText: labelHint,
            labelStyle: const TextStyle(
              color: ColorManager.white2,
              fontSize: FontSize.s14,
              letterSpacing: SizeManager.s1_5,
              fontWeight: FontWightManager.semiBold,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
