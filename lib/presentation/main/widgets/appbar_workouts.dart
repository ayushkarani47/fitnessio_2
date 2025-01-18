import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkoutsPageAppBarWidget extends StatelessWidget {
  const WorkoutsPageAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: SizeManager.s50,
      automaticallyImplyLeading: false,
      elevation: SizeManager.s0,
      title: Text(AppLocalizations.of(context)!.workoutsABtitle,
        //StringsManager.workoutsABtitle,
        style: StyleManager.appbarTitleTextStyle,
      ),
    ).animate().fadeIn(
          duration: 500.ms,
        );
  }
}
