import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/home/providers/home_provider.dart';
import 'package:Fitnessio/presentation/profile/providers/profile_provider.dart';
import 'package:Fitnessio/presentation/settings/widgets/change_password_app_bar.dart';
import 'package:Fitnessio/utils/managers/asset_manager.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/widgets/lime_green_rounded_button.dart';
import 'package:Fitnessio/utils/widgets/text_field_underlined.dart';

class ChangeWeightPage extends StatefulWidget {
  const ChangeWeightPage({super.key});

  @override
  State<ChangeWeightPage> createState() => _ChangeWeightPageState();
}

class _ChangeWeightPageState extends State<ChangeWeightPage> {
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _weightController.text = homeProvider.userData['weight'].toString();
    super.initState();
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  Future<void> changeWeight() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    try {
      await homeProvider
          .getUsersBMI(
            height: homeProvider.userData['height'],
            weight: double.parse(_weightController.text),
          )
          .then((_) => homeProvider.getUsersBMR(
                gender: homeProvider.userData['gender'],
                weight: double.parse(_weightController.text),
                height: homeProvider.userData['height'],
                age: homeProvider.userData['age'],
                activity: homeProvider.userData['activity'],
                goal: homeProvider.userData['goal'],
              ))
          .then(
            (_) => profileProvider.changeUsersWeight(
              bmi: homeProvider.usersBMI,
              bmr: homeProvider.userBMRwithGoal,
              weight: double.parse(_weightController.text),
              weightDateTime: DateTime.now().month,
              context: context,
            ),
          )
          .then(
            (_) => homeProvider.fetchUserData(),
          )
          .then(
            (_) => Navigator.of(context).pop(),
          );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          SizeManager.s60.h,
        ),
        child: const ChangeDataPagesAppBar(),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(PaddingManager.p28),
                child: Text(
                  StringsManager.changeWeightText,
                  textAlign: TextAlign.center,
                  style: StyleManager.settingsOptionTiteTextStyle,
                ),
              ),
              SizedBox(
                child: Image.asset(
                  ImageManager.weight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(PaddingManager.p28),
                child: TextFieldWidgetUnderLined(
                  readOnly: false,
                  controller: _weightController,
                  labelHint: StringsManager.weightHint,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                ),
              ),
              LimeGreenRoundedButtonWidget(
                onTap: changeWeight,
                title: StringsManager.proceed,
              )
            ],
          ),
        ),
      )),
    ).animate().fadeIn(
          duration: 500.ms,
        );
  }
}
