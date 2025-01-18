import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/auth/providers/auth_provider.dart';
import 'package:Fitnessio/utils/widgets/text_field_widget.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/font_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/widgets/lime_green_rounded_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      appBar: AppBar(
        backgroundColor: ColorManager.darkGrey,
        elevation: SizeManager.s0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: PaddingManager.p28),
              child: Center(
                child: Text(
                  StringsManager.enterEmailToResetPw,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSize.s20.sp,
                    fontWeight: FontWightManager.semiBold,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ),
            TextFieldWidget(
              controller: emailController,
              labelHint: StringsManager.emailHint,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
            ),
            LimeGreenRoundedButtonWidget(
              onTap: () {
                authProvider.forgotPassword(
                  email: emailController.text,
                  context: context,
                );
              },
              title: StringsManager.resetPassword,
            )
          ],
        ),
      ),
    );
  }
}
