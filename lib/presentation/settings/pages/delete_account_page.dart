import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/settings/providers/settings_provider.dart';
import 'package:Fitnessio/presentation/settings/widgets/delete_account_app_bar.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/router/router.dart';
import 'package:Fitnessio/utils/widgets/lime_green_rounded_button.dart';
import 'package:Fitnessio/utils/widgets/text_field_underlined.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    Future<void> deleteAccount() async {
      if (isValid) {
        try {
          await settingsProvider
              .deleteUser(
                  email: _emailController.text,
                  password: _passwordController.text)
              .then((value) {
            setState(() {
              settingsProvider.signOut(context: context);
              Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
            });
          });
        } catch (e) {
          rethrow;
        }
      } else {
        Navigator.of(context).pop();
      }
    }

    popUp() {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(RadiusManager.r15.r),
              ),
              titleTextStyle: StyleManager.deleteAccPopUpTitleTextStyle,
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              backgroundColor: ColorManager.darkGrey,
              title: const Text(
                StringsManager.uSure,
                textAlign: TextAlign.center,
              ),
              actions: [
                GestureDetector(
                  onTap: deleteAccount,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.grey3,
                      borderRadius: BorderRadius.circular(RadiusManager.r15.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(PaddingManager.p8),
                      child: Text(
                        StringsManager.yes,
                        style: StyleManager.deleteAccPopUpButtonTextStyle,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.grey3,
                      borderRadius: BorderRadius.circular(RadiusManager.r15.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: PaddingManager.p8,
                        bottom: PaddingManager.p8,
                        right: PaddingManager.p14,
                        left: PaddingManager.p14,
                      ),
                      child: Text(
                        StringsManager.no,
                        style: StyleManager.deleteAccPopUpButtonTextStyle,
                      ),
                    ),
                  ),
                )
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          SizeManager.s60.h,
        ),
        child: const DeleteAccountPageAppBar(),
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
                  StringsManager.deleteAccContent,
                  textAlign: TextAlign.center,
                  style: StyleManager.settingsOptionTiteTextStyle,
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
                  controller: _emailController,
                  labelHint: StringsManager.emailHint,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
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
                  controller: _passwordController,
                  labelHint: StringsManager.passwordHint,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                ),
              ),
              LimeGreenRoundedButtonWidget(
                onTap: popUp,
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

  bool get isValid {
    return _emailController.text.isNotEmpty ||
        _passwordController.text.isNotEmpty;
  }
}
