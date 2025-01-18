import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Fitnessio/utils/managers/asset_manager.dart';
import 'package:Fitnessio/utils/managers/color_manager.dart';
import 'package:Fitnessio/utils/managers/string_manager.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:Fitnessio/presentation/boarding/widgets/slider_boarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class BoardingPage extends StatefulWidget {
  const BoardingPage({super.key});

  @override
  State<BoardingPage> createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: DurationManager.s5),
        (Timer timer) {
      int nextPage = _pageController.page!.round() + 1;
      _pageController.animateToPage(
        nextPage % imgList.length,
        duration: const Duration(milliseconds: DurationManager.ms300),
        curve: Curves.easeInOut,
      );
    });
  }

  List<String> imgList = [
    ImageManager.splashBG1WP,
    ImageManager.splashBG2WP,
    ImageManager.splashBG3WP,
    ImageManager.splashBG4WP,
    ImageManager.splashBG5WP,
    ImageManager.splashBG6WP,
    ImageManager.splashBG7WP,
  ];

  @override
  Widget build(BuildContext context) {
    for (var item in imgList) {
      precacheImage(ExactAssetImage(item), context);
    }
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: imgList.map(
              (item) {
                return Center(
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                    height: height,
                  ),
                );
              },
            ).toList(),
            onPageChanged: (value) {
              if (value == imgList.length - 1) {
                Future.delayed(
                  const Duration(
                    seconds: DurationManager.s5,
                  ),
                ).then(
                  (value) => _pageController.animateToPage(
                    0,
                    duration:
                        const Duration(milliseconds: DurationManager.ms300),
                    curve: Curves.easeInOut,
                  ),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: SizeManager.s400.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorManager.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      RadiusManager.r15.r,
                    ),
                    topRight: Radius.circular(
                      RadiusManager.r15.r,
                    ),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: PaddingManager.p28),
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: imgList.length,
                      effect: CustomizableEffect(
                        spacing: SizeManager.s16,
                        dotDecoration: DotDecoration(
                          width: SizeManager.s8.w,
                          height: SizeManager.s8.h,
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(
                            RadiusManager.r24.r,
                          ),
                          dotBorder: DotBorder(
                            width: SizeManager.s1_5.w,
                            color: ColorManager.white,
                          ),
                        ),
                        activeDotDecoration: DotDecoration(
                          width: SizeManager.s20.w,
                          height: SizeManager.s20.h,
                          borderRadius: BorderRadius.circular(
                            RadiusManager.r24.r,
                          ),
                          color: ColorManager.black87,
                          dotBorder: DotBorder(
                            width: SizeManager.s1_5.w,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: PaddingManager.p28),
                    child: Text(
                      AppLocalizations.of(context)!.splashtext,
                      style: StyleManager.splashText1TextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: PaddingManager.p28),
                    child: Text(
                      StringsManager.splashText2,
                      style: StyleManager.splashText2TextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SliderBoardingWidget()
                ],
              ).animate().fadeIn(duration: 500.ms),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }
}
