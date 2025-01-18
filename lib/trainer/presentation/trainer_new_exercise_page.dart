//import 'package:Fitnessio/presentation/auth/providers/auth_provider.dart';
import 'package:Fitnessio/utils/widgets/text_field_underlined.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/workouts/providers/workout_provider.dart';
import 'package:Fitnessio/presentation/workouts/widgets/workouts_app_bar.dart';
import 'package:Fitnessio/utils/managers/asset_manager.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/list_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/widgets/lime_green_rounded_button.dart';
import 'package:Fitnessio/utils/widgets/small_text_field_widget.dart';

class TrainerNewExercisePage extends StatefulWidget {
  final Map<String, dynamic> user;
  const TrainerNewExercisePage({super.key,required this.user});

  @override
  State<TrainerNewExercisePage> createState() => _TrainerNewExercisePageState();
}

class _TrainerNewExercisePageState extends State<TrainerNewExercisePage> {
  final TextEditingController _setNumberController = TextEditingController();
  final TextEditingController _repNumberController = TextEditingController();
  final TextEditingController _mealDateController = TextEditingController();
  String? _valueExercise;

  @override
  void dispose() {
    _setNumberController.dispose();
    _repNumberController.dispose();
    _mealDateController.dispose();

    super.dispose();
  }

  void _onChangedExercise(Object? selectedGenderValue) {
    if (selectedGenderValue is String) {
      setState(() {
        _valueExercise = selectedGenderValue;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _mealDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final workoutProvider =
        Provider.of<WorkoutProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          deviceWidth,
          SizeManager.s60.h,
        ),
        child: const NewExercisePageAppBar(),
      ),
      backgroundColor: ColorManager.darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: PaddingManager.p8),
                child: SizedBox(
                  width: SizeManager.s250.w,
                  height: SizeManager.s250.h,
                  child: Image.asset(
                    ImageManager.exerciseLogo,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: PaddingManager.p28,
                  right: PaddingManager.p28,
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
                      //  barrierColor: ColorManager.,
                      // dropdownMaxHeight: deviceHeight / 2,
                      // dropdownDecoration: BoxDecoration(
                      //   color: ColorManager.darkGrey,
                      //   borderRadius: BorderRadius.circular(
                      //     RadiusManager.r15.r,
                      //   ),
                      // ),
                      onChanged: _onChangedExercise,
                      value: _valueExercise,
                      //iconSize: SizeManager.s0,
                      hint: Text(
                        StringsManager.exerciseHint,
                        style: StyleManager.registerTextfieldTextStyle,
                      ),
                      items: ListManager.exercisesList,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(PaddingManager.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallTextFieldWidget(
                      controller: _setNumberController,
                      labelHint: StringsManager.setNumberHint,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                    ),
                    SmallTextFieldWidget(
                      controller: _repNumberController,
                      labelHint: StringsManager.repNumberHint,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: PaddingManager.p28,
                  right: PaddingManager.p28,
                  top: PaddingManager.p12,
                ),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context); // Show the date picker on tap
                  },
                  child: AbsorbPointer(
                    child: TextFieldWidgetUnderLined(
                      controller: _mealDateController,
                      labelHint: "Select Exercise Date",
                      keyboardType: TextInputType.none,
                      obscureText: false,
                      readOnly: true,
                    ),
                  ),
                ),
              ),
              LimeGreenRoundedButtonWidget(
                onTap: () {
                  try {
                    workoutProvider.addNewWorkoutTrainer(
                      userId: widget.user['id'],
                      name: _valueExercise!,
                      repNumber: int.parse(_repNumberController.text),
                      setNumber: int.parse(_setNumberController.text),
                      dateTime: _mealDateController.text.isNotEmpty
                          ? DateTime.parse(_mealDateController.text)
                          : DateTime.now(),
                    );
                    workoutProvider.getProgressPercent();
                    Navigator.of(context).pop();
                  } catch (e) {
                    rethrow;
                  }
                },
                title: StringsManager.add,
              )
            ],
          ),
        ),
      ),
    );
  }
}
