import 'package:flutter/material.dart';
import 'package:jit_test/provider/auth_provider.dart';
import 'package:jit_test/provider/transaction_provider.dart';
import 'package:jit_test/ui/splash_screen/splash_screen_wrapper.dart';
import 'package:provider/provider.dart';

import 'const/app_constants.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        navigatorKey: AppConstants.globalNavKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.grey,
            primaryColor: Colors.green), // Other theme configurations...
        home: const SplashScreenWrapper(),
      ),
    );
  }
}
