import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/presentation/consumption/providers/consumption_provider.dart';
import 'package:Fitnessio/presentation/home/widgets/fitness_data_widget.dart';
import 'package:Fitnessio/presentation/home/widgets/carousel_slider_home_widget.dart';
import 'package:Fitnessio/presentation/home/widgets/home_page_text_spacer_widget.dart';
import 'package:Fitnessio/presentation/home/widgets/todays_progress_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConsumptionProvider>(context, listen: false).fetchAndSetMeals();
    Provider.of<ConsumptionProvider>(context, listen: false).fetchAndSetWater();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TodaysProgressWidget(),
            HomePageTextSpacerWidget(
              title: AppLocalizations.of(context)!.todaysAct,
              //StringsManager.todaysAct,
            ),
            FitnessDataWidget(),
            HomePageTextSpacerWidget(
              title:
              AppLocalizations.of(context)!.benefits,
              // StringsManager.benefits,
            ),
            CarouselSliderHomeWidget()
          ],
        ),
      ),
    ).animate().fadeIn(
          duration: 500.ms,
        );
  }
}
