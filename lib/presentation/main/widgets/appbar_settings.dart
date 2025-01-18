import 'package:Fitnessio/controller/language_change_controller.dart';
import 'package:Fitnessio/roles_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/auth/providers/auth_provider.dart';
import 'package:Fitnessio/presentation/settings/providers/settings_provider.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
enum Language { english, dutch }
class SettingsPageAppBarWidget extends StatefulWidget {

  const SettingsPageAppBarWidget({
    super.key,
  });

  @override
  State<SettingsPageAppBarWidget> createState() =>
      _SettingsPageAppBarWidgetState();
}

class _SettingsPageAppBarWidgetState extends State<SettingsPageAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
   Future<void> signOut(SettingsProvider settingsProvider, BuildContext context) async {
  await settingsProvider.signOut(context: context);
  
  // Get the email and password from user input or from your provider
  String email = 'user@example.com';  // Replace with actual email
  String password = 'userpassword';   // Replace with actual password

  // Call authProvider.callAuth with the required arguments
  await authProvider.callAuth(
    email: email,
    password: password,
    context: context,
  );
  
  // After signing out, navigate to RoleSelectionPage
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) {
      return const RoleSelectionPage();
    }),
    (route) => false,
  );
}

    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: SizeManager.s50,
      automaticallyImplyLeading: false,
      elevation: SizeManager.s0,
      title: Text(
        StringsManager.settingsABtitle,
        style: StyleManager.appbarTitleTextStyle,
      ),
      actions: [
         Consumer<LanguageChangeController>(builder: (context, provider, child) {
          return PopupMenuButton(
            onSelected: (Language item) {
              if (Language.english.name == item.name) {
                provider.changeLanguage(Locale('en'));
              }
              else if (Language.dutch.name == item.name) {
                provider.changeLanguage(Locale('nl'));
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Language>>[
              PopupMenuItem(
                value: Language.english,
                child: Text("English"),
              ),
              PopupMenuItem(
                value: Language.dutch,
                child: Text("Dutch"),
              ),
            ],
          );
        }),


        Padding(
          padding: const EdgeInsets.only(right: PaddingManager.p12),
          child: Container(
            height: SizeManager.s40.h,
            width: SizeManager.s40.w,
            decoration: BoxDecoration(
              color: ColorManager.grey3,
              borderRadius: BorderRadius.circular(
                RadiusManager.r40.r,
              ),
            ),
            child: IconButton(
              splashColor: ColorManager.grey3,
              onPressed: () => signOut(settingsProvider, context),
              icon: const Icon(
                Icons.logout_sharp,
                size: SizeManager.s26,
                color: ColorManager.white,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(
          duration: 500.ms,
        );
  }
}
