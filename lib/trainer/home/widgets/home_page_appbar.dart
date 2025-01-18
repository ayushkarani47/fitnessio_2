import 'package:Fitnessio/presentation/settings/providers/settings_provider.dart';
import 'package:Fitnessio/roles_page.dart';
import 'package:Fitnessio/trainer/auth/provider/auth_provider_trainer.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePageAppbar extends StatefulWidget {
  const HomePageAppbar({super.key});

  @override
  State<HomePageAppbar> createState() => _HomePageAppbarState();
}

class _HomePageAppbarState extends State<HomePageAppbar> {


  
  @override
  Widget build(BuildContext context) {
    final settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProviderTrainer>(context, listen: false);
    Future<void> signOut(
        SettingsProvider settingsProvider, BuildContext context) async {
      await settingsProvider.signOut(context: context);
      authProvider.callAuth();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
        return const RoleSelectionPage();
      }), (route) => false);
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: SizeManager.s50,
      automaticallyImplyLeading: false,
      elevation: SizeManager.s0,
      title: Text(
        "",
        style: StyleManager.appbarTitleTextStyle,
      ),
      actions: [
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