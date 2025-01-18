import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/home/providers/home_provider.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePageAppBarWidget extends StatelessWidget {
  const HomePageAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return FutureBuilder<Map<String, dynamic>>(
        future: homeProvider.fetchUserData(),
        builder: (context, snapshot) {
          return AppBar(
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: SizeManager.s40.h,
                    width: SizeManager.s40.h,
                    decoration: BoxDecoration(
                      color: ColorManager.grey3,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: IconButton(
                      padding: EdgeInsets.only(bottom: 0),
                      alignment: Alignment.center,
                      splashColor: ColorManager.grey3,
                      onPressed: () {
                        //TODO:::
                      },
                      icon: const Icon(
                        Icons.notifications_none_sharp,
                        size: SizeManager.s26,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: false,
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: SizeManager.s50,
            automaticallyImplyLeading: false,
            elevation: SizeManager.s0,
            title: Padding(
              padding: const EdgeInsets.all(PaddingManager.p12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcomeback,
                    textAlign: TextAlign.left,
                    style: StyleManager.homeTitleNameTextStyle,
                  ),
                  Text(
                    '${homeProvider.userData['name']} ${homeProvider.userData['surname']}!',
                    style: StyleManager.homeTitleDataTextStyle,
                  )
                ],
              ),
            ),
          ).animate().fadeIn(
                duration: 500.ms,
              );
        });
  }
}
