import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../home/transactions_screen.dart';
import '../login/login_screen.dart';
import 'splash_screen.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AuthProvider>(context).checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Navigate to the appropriate screen based on login status
          return snapshot.data! ? const TransactionScreen() : LoginScreen();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
