import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConsumptionPageAppBarWidget extends StatelessWidget {
  const ConsumptionPageAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: SizeManager.s50,
      automaticallyImplyLeading: false,
      elevation: SizeManager.s0,
      title: Text(AppLocalizations.of(context)!.consumptionABtitle,
        //StringsManager.consumptionABtitle,
        style: StyleManager.appbarTitleTextStyle,
      ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: PaddingManager.p12),
      //     child: Container(
      //       height: SizeManager.s40.h,
      //       width: SizeManager.s40.h,
      //       decoration: BoxDecoration(
      //         color: ColorManager.grey3,
      //         borderRadius: BorderRadius.circular(
      //           RadiusManager.r40.r,
      //         ),
      //       ),
      //       child: IconButton(
      //         padding: EdgeInsets.only(bottom: 0),
      //         splashColor: ColorManager.grey3,
      //         onPressed: () =>
      //             Navigator.of(context).pushNamed(Routes.newMealRoute),
      //         icon: const Icon(
      //           Icons.add,
      //           size: SizeManager.s26,
      //           color: ColorManager.white,
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
    ).animate().fadeIn(
          duration: 500.ms,
        );
  }
}
