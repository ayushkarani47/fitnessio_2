import 'package:Fitnessio/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:Fitnessio/presentation/settings/widgets/button_settings.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

enum Language { english, dutch }

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: PaddingManager.p12,
                  bottom: PaddingManager.p12,
                  top: PaddingManager.p12,
                ),
                child: Text(
                  AppLocalizations.of(context)!.account,
                  style: StyleManager.settingsPageSpacerTextStyle,
                ),
              ),
            ),
            SettingsPageButton(
              deviceWidth: deviceWidth,
              onTap: () =>
                  Navigator.of(context).pushNamed(Routes.changeEmailRoute),
              iconData: Icons.email_outlined,
              title: AppLocalizations.of(context)!.changeemail,
            ),
            SettingsPageButton(
                deviceWidth: deviceWidth,
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.changePasswordRoute),
                iconData: Icons.lock_open_sharp,
                title: AppLocalizations.of(context)!.changepass),
            SettingsPageButton(
              deviceWidth: deviceWidth,
              onTap: () =>
                  Navigator.of(context).pushNamed(Routes.deleteAccRoute),
              iconData: Icons.delete_outlined,
              title: AppLocalizations.of(context)!.deleteaccount,
            )
                // SettingsPageButton(
                //   deviceWidth: deviceWidth,
                //   onTap: () =>
                //   iconData: Icons.language,
                //   title: AppLocalizations.of(context)!.changelanguage,
                // )
                .animate()
                .fadeIn(
                  duration: 500.ms,
                ),
          ],
        ),
      ),
    );
  }

  // PopupMenuButton? _showLanguageDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       Consumer<LanguageChangeController>(builder: (context, provider, child) {
  //         return PopupMenuButton(
  //           onSelected: (Language item) {
  //             if (Language.english.name == item.name) {
  //               provider.changeLanguage(Locale('en'));
  //             }
  //             else if (Language.dutch.name == item.name) {
  //               provider.changeLanguage(Locale('nl'));
  //             }
  //           },
  //           itemBuilder: (BuildContext context) => <PopupMenuEntry<Language>>[
  //             PopupMenuItem(
  //               value: Language.english,
  //               child: Text("English"),
  //             ),
  //             PopupMenuItem(
  //               value: Language.dutch,
  //               child: Text("Dutch"),
  //             ),
  //           ],
  //         );
  //       });
//       },
//     );
//   }
// }
}
