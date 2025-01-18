import 'dart:async'; // For Future.delayed
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Fitnessio/roles_page.dart';
import 'package:Fitnessio/trainer/presentation/trainer_main_page.dart';
import 'package:Fitnessio/presentation/main/pages/main_page.dart';
import 'package:Fitnessio/presentation/auth/providers/auth_provider.dart';
import 'package:Fitnessio/trainer/auth/provider/auth_provider_trainer.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<Widget> _delayedLogic(
      AuthProviderTrainer authProviderTrainer, AuthProvider authProvider) async {
    await Future.delayed(const Duration(seconds: 2)); // 2-second delay

    final trainer = authProviderTrainer.user;
    final user = authProvider.user;
    final hasAgeParameter = authProvider.hasAgeParameter;
    final hasAgeParameterTrainer = authProviderTrainer.hasAgeParameter;

    if (trainer != null && hasAgeParameterTrainer == true) {
      return const TrainerMainPage();
    } else if (trainer != null && hasAgeParameter == false) {
      return const MainPage();
    } else if (trainer == null) {
      return RoleSelectionPage();
    }

    return const RoleSelectionPage(); // Fallback
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider<AuthProviderTrainer>(
            create: (_) => AuthProviderTrainer(),
          ),
        ],
        child: Consumer2<AuthProvider, AuthProviderTrainer>(
          builder: (context, authProvider, authProviderTrainer, _) {
            return FutureBuilder<Widget>(
              future: _delayedLogic(authProviderTrainer, authProvider),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  ); // Show loading spinner while waiting
                } else if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return const RoleSelectionPage(); // Fallback in case of an error
                }
              },
            );
          },
        ),
      ),
    );
  }
}
