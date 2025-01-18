import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/widgets/small_text_field_widget.dart';
import 'package:Fitnessio/utils/widgets/text_field_underlined.dart';

// ignore: must_be_immutable
class AddTrainerDataWidgets extends StatelessWidget {
  AddTrainerDataWidgets({
    super.key,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.onChangedGender,
    required this.valueGender,
    required this.expInYears,
    required this.nameController,
    required this.surnameController,
  });

  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController surnameController;
  final TextEditingController nameController;
  final TextEditingController expInYears;
  Object? valueGender;
  void Function(Object?)? onChangedGender;

  @override
  Widget build(BuildContext context) {
    List<Widget> addDataList = [
      Padding(
        padding: const EdgeInsets.only(
          left: PaddingManager.p28,
          right: PaddingManager.p28,
          bottom: PaddingManager.p12,
        ),
        child: TextFieldWidgetUnderLined(
          readOnly: false,
          controller: nameController,
          labelHint: StringsManager.nameHint,
          obscureText: false,
          keyboardType: TextInputType.text,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: PaddingManager.p28,
          right: PaddingManager.p28,
          bottom: PaddingManager.p12,
        ),
        child: TextFieldWidgetUnderLined(
          readOnly: false,
          controller: surnameController,
          labelHint: StringsManager.surnameHint,
          obscureText: false,
          keyboardType: TextInputType.text,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: PaddingManager.p28,
          right: PaddingManager.p28,
          bottom: PaddingManager.p12,
        ),
        child: TextFieldWidgetUnderLined(
          readOnly: false,
          controller: ageController,
          labelHint: StringsManager.ageHint,
          obscureText: false,
          keyboardType: TextInputType.number,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: PaddingManager.p28,
          right: PaddingManager.p28,
          bottom: PaddingManager.p12,
          top: PaddingManager.p12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallTextFieldWidget(
              controller: heightController,
              labelHint: StringsManager.heightHint,
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
            SmallTextFieldWidget(
              controller: weightController,
              labelHint: StringsManager.weightHint,
              obscureText: false,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: PaddingManager.p28,
          right: PaddingManager.p28,
          bottom: PaddingManager.p12,
        ),
        child: Container(
          width: SizeManager.s400.w,
          height: SizeManager.s50.h,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ColorManager.limerGreen2,
                width: SizeManager.s0_7.h,
              ),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              onChanged: onChangedGender,
              value: valueGender,
              hint: Text(
                StringsManager.genderHint,
                style: StyleManager.registerTextfieldTextStyle,
              ),
              items: [
                DropdownMenuItem(
                  value: StringsManager.genderManHint,
                  child: Text(
                    StringsManager.genderManHint,
                    style: StyleManager.registerTextfieldTextStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: StringsManager.genderWomanHint,
                  child: Text(
                    StringsManager.genderWomanHint,
                    style: StyleManager.registerTextfieldTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: PaddingManager.p28,
          right: PaddingManager.p28,
          bottom: PaddingManager.p12,
        ),
        child: TextFieldWidgetUnderLined(
          readOnly: false,
          controller: expInYears,
          labelHint: StringsManager.expHint, // Add this key in StringsManager
          obscureText: false,
          keyboardType: TextInputType.number,
        ),
      ),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: addDataList,
    );
  }
}
