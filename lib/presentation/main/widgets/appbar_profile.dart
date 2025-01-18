import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';

class ProfilePageAppBarWidget extends StatefulWidget {
  const ProfilePageAppBarWidget({
    super.key,
  });

  @override
  State<ProfilePageAppBarWidget> createState() =>
      _ProfilePageAppBarWidgetState();
}

class _ProfilePageAppBarWidgetState extends State<ProfilePageAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: SizeManager.s50,
      automaticallyImplyLeading: false,
      elevation: SizeManager.s0,
    ).animate().fadeIn(
          duration: 500.ms,
        );
  }
}
