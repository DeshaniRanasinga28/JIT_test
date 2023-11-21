import 'package:flutter/material.dart';
import 'package:jit_test/model/user_model.dart';
import 'package:provider/provider.dart';

import '../../commen_widget/custom_elevated_button.dart';
import '../../commen_widget/custom_text_form_field.dart';
import '../../const/color_const.dart';
import '../../const/string_const.dart';
import '../../provider/auth_provider.dart';
import 'login_screen.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<UserRegistrationScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Text(
          StringConst.userRegistrationLabel,
          style: TextStyle(color: ColorPalette.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorPalette.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40.0,
              ),
              CustomTextFormField(
                controller: usernameController,
                labelText: StringConst.usernameLabel,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomTextFormField(
                controller: passwordController,
                labelText: StringConst.passwordLabel,
              ),
              const SizedBox(
                height: 40.0,
              ),
              CustomElevatedButton(
                onPressed: () => _submitForm(context),
                label: StringConst.saveLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final userModel = UserModel(
          name: usernameController.text, password: passwordController.text);
      Provider.of<AuthProvider>(context, listen: false)
          .addUser(usernameController.text, passwordController.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
      clearControllers();
    }
  }

  clearControllers() {
    usernameController.clear();
    passwordController.clear();
  }
}
