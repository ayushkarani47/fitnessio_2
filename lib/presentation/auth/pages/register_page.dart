import 'package:Fitnessio/presentation/auth/providers/auth_provider.dart' as fitnessio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/utils/managers/asset_manager.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/utils/widgets/lime_green_rounded_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
 String getTrainerEmail() {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null && currentUser.email != null) {
    return currentUser.email!;
  } else {
    throw Exception("No trainer is currently logged in.");
  }
}
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
      final TextEditingController _yourPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp(BuildContext context) async {
    final authProvider = Provider.of<fitnessio.AuthProvider>(context, listen: false);
    try {
      await authProvider.register(
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
        trainerEmail: getTrainerEmail(),
        trainersPassword: _yourPasswordController.text,
        
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(PaddingManager.p12),
            child: Column(
              children: [
                SizedBox(
                  width: SizeManager.s250.w,
                  height: SizeManager.s250.h,
                  child: Image.asset(ImageManager.logo),
                ),
                TextField(
                  style: StyleManager.registerTextfieldTextStyle,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                TextField(
                  style: StyleManager.registerTextfieldTextStyle,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                ),
                TextField(
                  style: StyleManager.registerTextfieldTextStyle,
                  controller: _repeatPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Repeat Password",
                  ),
                ),
                TextField(
                  style: StyleManager.registerTextfieldTextStyle,
                  controller: _yourPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Your Password",
                  ),
                ),
                LimeGreenRoundedButtonWidget(
                  onTap: () => _signUp(context),
                  title: StringsManager.signUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
