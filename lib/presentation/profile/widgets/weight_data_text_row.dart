import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/home/providers/home_provider.dart';
import 'package:Fitnessio/utils/managers/asset_manager.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';

class WeightDataTextRowWidget extends StatelessWidget {
  const WeightDataTextRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) => Padding(
        padding: const EdgeInsets.only(
          right: PaddingManager.p12,
          left: PaddingManager.p12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: SizeManager.s35.h,
              width: SizeManager.s35.w,
              child: Image.asset(
                ImageManager.weightIc,
                color: ColorManager.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: PaddingManager.p12),
              child: Text(
                StringsManager.weightData,
                style: StyleManager.weightDataRowTextStyleWhite,
              ),
            ),
            const Expanded(child: SizedBox()),
            Text(
              homeProvider.userData['weight'].toString(),
              style: StyleManager.weightDataRowTextStyleLime,
            ),
            Padding(
              padding: const EdgeInsets.only(left: PaddingManager.p3),
              child: Text(
                StringsManager.kg,
                style: StyleManager.weightDataRowTextStyleWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}
