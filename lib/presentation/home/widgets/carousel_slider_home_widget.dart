import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:Fitnessio/presentation/home/widgets/carousel_home_box.dart';
import 'package:Fitnessio/utils/managers/asset_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarouselSliderHomeWidget extends StatelessWidget {
  const CarouselSliderHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      items: [
        CarouselHomeBox(
          deviceWidth: deviceWidth,
          image: ImageManager.carousel1WP,
          onTap: () {
            //TODO
          },
          title: AppLocalizations.of(context)!.strengh,
          //StringsManager.strengh,
        ),
        CarouselHomeBox(
          deviceWidth: deviceWidth,
          image: ImageManager.carousel2WP,
          onTap: () {
            //TODO
          },
          title: AppLocalizations.of(context)!.yoga,
         // StringsManager.yoga,
        ),
        CarouselHomeBox(
          deviceWidth: deviceWidth,
          image: ImageManager.carousel3WP,
          onTap: () {
            //TODO
          },
          title: AppLocalizations.of(context)!.power,
          //StringsManager.power,
        ),
        CarouselHomeBox(
          deviceWidth: deviceWidth,
          image: ImageManager.carousel4WP,
          onTap: () {
            //TODO
          },
          title:AppLocalizations.of(context)!.focus,
          // StringsManager.focus,
        ),
        CarouselHomeBox(
          deviceWidth: deviceWidth,
          image: ImageManager.carousel5WP,
          onTap: () {
            //TODO
          },
          title:AppLocalizations.of(context)!.confidence,
          // StringsManager.confidence,
        ),
      ],
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );
  }
}
