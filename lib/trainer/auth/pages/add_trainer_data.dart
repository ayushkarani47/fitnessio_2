import 'package:Fitnessio/trainer/auth/provider/auth_provider_trainer.dart';
import 'package:Fitnessio/trainer/home/provider/trainer_home_provider.dart';
import 'package:Fitnessio/trainer/home/widgets/add_trainer_data_widgets.dart';
import 'package:Fitnessio/trainer/presentation/trainer_main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/widgets/lime_green_rounded_button.dart';

class AddTrainerDataPage extends StatefulWidget {
  const AddTrainerDataPage({super.key});

  @override
  State<AddTrainerDataPage> createState() => _AddTrainerDataPageState();
}

class _AddTrainerDataPageState extends State<AddTrainerDataPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String? _valueGender;
  final TextEditingController _expInYearsController = TextEditingController();

  void _onChangedGender(Object? selectedGenderValue) {
    if (selectedGenderValue is String) {
      setState(() {
        _valueGender = selectedGenderValue;
      });
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProviderTrainer = Provider.of<AuthProviderTrainer>(context);
    final email = authProviderTrainer.user!.email;
    final trainerHomeProvider = Provider.of<TrainerHomeProvider>(context, listen: false);

    Future<void> addUserData() async {
      try {
        await authProviderTrainer.addUserData(
          email: email!,
          name: _nameController.text,
          surname: _surnameController.text,
          age: int.parse(_ageController.text),
          context: context,
          gender: _valueGender!,
          height: double.parse(_heightController.text),
          weight: double.parse(_weightController.text),
          expInYears: int.parse(_expInYearsController.text),
        );
      } catch (e) {
        rethrow;
      }
    }

    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      appBar: AppBar(
        backgroundColor: ColorManager.darkGrey,
        elevation: SizeManager.s0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: PaddingManager.p28),
                child: Center(
                  child: Text(
                    StringsManager.enterData,
                    textAlign: TextAlign.center,
                    style: StyleManager.addDataTitleTextStyle,
                  ),
                ),
              ),
              AddTrainerDataWidgets(
                ageController: _ageController,
                heightController: _heightController,
                weightController: _weightController,
                onChangedGender: _onChangedGender,
                valueGender: _valueGender,
                expInYears: _expInYearsController,
                nameController: _nameController,
                surnameController: _surnameController,
              ),
              LimeGreenRoundedButtonWidget(
                onTap: () {
                  addUserData().then(
                    (value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TrainerMainPage()), (route) => false),
                  );
                },
                title: StringsManager.proceed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
