import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commen_widget/custom_elevated_button.dart';
import '../../commen_widget/custom_snack_bar.dart';
import '../../commen_widget/custom_text_form_field.dart';
import '../../const/string_const.dart';
import '../../provider/auth_provider.dart';
import '../home/home_screen.dart';
import 'user_registration.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                  fontSize: 42.0,
                  fontFamily: "Lora",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            CustomTextFormField(
              controller: _usernameController,
              labelText: StringConst.usernameLabel,
            ),
            const SizedBox(
              height: 20.0,
            ),
            CustomTextFormField(
              controller: _passwordController,
              labelText: StringConst.passwordLabel,
            ),
            const SizedBox(
              height: 40.0,
            ),
            CustomElevatedButton(
              onPressed: () => _userLogin(context),
              label: StringConst.loginLabel,
            ),
            const SizedBox(
              height: 40.0,
            ),
            InkWell(
              onTap: () => navigateToUserRegistration(context),
              child: const Text(
                StringConst.registrationLabel,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12.0,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _userLogin(BuildContext context) async {
    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
        _usernameController.text,
        _passwordController.text,
      );
      navigateToHome(context);
    } catch (e) {
      log("ERROR: ${e.toString()}");
      CustomSnackBar.showSnackBar(StringConst.invalidCredentialsError);
    }
  }

  navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      // MaterialPageRoute(builder: (context) => const TransactionScreen()),
    );
  }

  navigateToUserRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserRegistrationScreen()),
      // MaterialPageRoute(builder: (context) => const CreateUserScreen()),
    );
  }
}
