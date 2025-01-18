import 'package:flutter/material.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/font_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/widgets/neu_dark_container_widget.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.labelHint,
    required this.obscureText,
    required this.keyboardType,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String labelHint;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return NeuButton(
      width: deviceWidth,
      height: SizeManager.s70,
      radius: RadiusManager.r15,
      child: Padding(
        padding: const EdgeInsets.all(PaddingManager.p8),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          textAlign: TextAlign.start,
          style: const TextStyle(color: ColorManager.limeGreen),
          autocorrect: false,
          keyboardType: keyboardType,
          cursorColor: ColorManager.limeGreen,
          decoration: InputDecoration(
            labelText: labelHint,
            labelStyle: const TextStyle(
              color: ColorManager.limeGreen,
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
