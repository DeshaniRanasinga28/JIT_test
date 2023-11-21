import 'package:flutter/material.dart';

import '../const/color_const.dart';
import '../main.dart';

class CustomSnackBar {
  static showSnackBar(String title,
      {Color backgroundColor = ColorPalette.white,
      Color textColor = ColorPalette.black}) async {
    if ((title).isNotEmpty) {
      SnackBar snackBar = SnackBar(
          key: Key("snackbar"),
          behavior: SnackBarBehavior.floating,
          content: Container(
            width: 100.0,
            height: 20.0,
            alignment: Alignment.bottomCenter,
            child: Text(title, style: TextStyle(color: textColor)),
          ),
          backgroundColor: backgroundColor);
      await removeSnackBar();
      rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    }
  }

  static removeSnackBar() {
    rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  }
}
