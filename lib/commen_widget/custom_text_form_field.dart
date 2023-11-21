import 'package:flutter/material.dart';

import '../const/color_const.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomTextFormField(
      {super.key, required this.controller, required this.labelText});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: ColorPalette.black),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorPalette.black)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Please enter a value';
          }
          return null;
        },
      ),
    );
  }
}
