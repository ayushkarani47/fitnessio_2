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
class AddDataWidgets extends StatelessWidget {
  AddDataWidgets({
    super.key,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.onChangedGender,
    required this.valueGender,
    required this.valueActivity,
    required this.onChangedActivity,
    required this.nameController,
    required this.surnameController,
    required this.onChangedGoal,
    required this.valueGoal,
  });

  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController surnameController;
  final TextEditingController nameController;

  Object? valueGender;
  void Function(Object?)? onChangedGender;
  Object? valueActivity;
  void Function(Object?)? onChangedActivity;
  Object? valueGoal;
  void Function(Object?)? onChangedGoal;

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
            child: DropdownButton(
              onChanged: onChangedActivity,
              value: valueActivity,
              iconSize: SizeManager.s0,
              hint: Text(
                StringsManager.activityHint,
                style: StyleManager.registerTextfieldTextStyle,
              ),
              items: [
                DropdownMenuItem(
                  value: StringsManager.activityLowHint,
                  child: Text(
                    StringsManager.activityLowHint,
                    style: StyleManager.registerTextfieldTextStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: StringsManager.activityLightHint,
                  child: Text(
                    StringsManager.activityLightHint,
                    style: StyleManager.registerTextfieldTextStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: StringsManager.activityModerateHint,
                  child: Text(
                    StringsManager.activityModerateHint,
                    style: StyleManager.registerTextfieldTextStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: StringsManager.activityHighHint,
                  child: Text(
                    StringsManager.activityHighHint,
                    style: StyleManager.registerTextfieldTextStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: StringsManager.activityVeryHighHint,
                  child: Text(
                    StringsManager.activityVeryHighHint,
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
              onChanged: onChangedGoal,
              value: valueGoal,
              hint: Text(
                StringsManager.goalHint,
                style: StyleManager.registerTextfieldTextStyle,
              ),
              items: [
                DropdownMenuItem(
                  value: StringsManager.lose,
                  child: Text(
                    StringsManager.loseWeightHint,
                    style: StyleManager.registerTextfieldTextStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: StringsManager.maintain,
                  child: Text(
                    StringsManager.maintainWeightHint,
                    style: StyleManager.registerTextfieldTextStyle,
                  ),
                ),
                DropdownMenuItem(
                  value: StringsManager.gain,
                  child: Text(
                    StringsManager.gainWeightHint,
                    style: StyleManager.registerTextfieldTextStyle,
                  ),
                ),
              ],
            ),
          ),
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

class NewExercisePage extends StatefulWidget {
  const NewExercisePage({super.key});
  @override
  State<NewExercisePage> createState() => _NewExercisePageState();
}

class _NewExercisePageState extends State<NewExercisePage> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: WorkoutsAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                // items: ListManager.items
                //     .map((item) => DropdownMenuItem<String>(
                //           value: item,
                //           child: Text(
                //             item,
                //             style: const TextStyle(
                //               fontSize: 14,
                //             ),
                //           ),
                //         ))
                //     .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
                },
                // iconSize: 24, // Set the icon size here
                // buttonHeight: 50,
                // buttonWidth: 160,
                // itemHeight: 40,
                items: [],
              ),
            ),
            // Other widgets...
          ],
        ),
      ),
    );
  }
}
