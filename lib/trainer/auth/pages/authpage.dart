import 'package:Fitnessio/roles_page.dart';
import 'package:Fitnessio/trainer/auth/provider/auth_provider_trainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:Fitnessio/presentation/auth/providers/auth_provider.dart';
import 'package:Fitnessio/presentation/main/pages/main_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProviderTrainer>(
        builder: (context, authProvider, _) {
          final user = authProvider.user;
          final hasAgeParameter = authProvider.hasAgeParameter;
          var isRegisteredUser = user != null && hasAgeParameter == true;
          var isAddDataMode = user != null && hasAgeParameter == false;
          if (isRegisteredUser) {
            return const MainPage();
          } 
          // else if (isAddDataMode) {
          //   return const AddDataPage();
          // }
           else {
            return RoleSelectionPage();
            //return const LoginPage();
          }
        },
      ),
    );
  }
}
