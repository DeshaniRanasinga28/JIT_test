import 'package:flutter/material.dart';
import 'package:jit_test/ui/home/transactions_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TransactionScreen(),
    );
  }
}
