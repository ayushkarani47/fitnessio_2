import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/router/router.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';

class SliderBoardingWidget extends StatelessWidget {
  const SliderBoardingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
    return Padding(

      padding: const EdgeInsets.all(PaddingManager.p28),
      child: SlideAction(
       // height: height*0.052,
        outerColor: ColorManager.black87,
        innerColor: ColorManager.limeGreen,
        sliderButtonIcon: const Icon(Icons.double_arrow_sharp),
        text: StringsManager.swipeToPrc,
        onSubmit: () async {
          await Future.delayed(const Duration(milliseconds: 500));
          // ignore: use_build_context_synchronously
          
           Navigator.of(context).pushReplacementNamed(Routes.authRoute);
        },
      ),
    );
  }
}
