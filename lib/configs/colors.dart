import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColorInlima = Color(0xFF2B4C7E);
  static const Color buttonColorInlima = Color(0xFF2B4C7E);
  static const Color secondaryColorInlima = Color(0xFF567EBB);
  static const Color tertiaryColorInlima = Color(0xFF606D80);
  static const Color blackInlima = Color(0xFF201F20);
  static const Color lightGreyInlima = Color(0xFFDCE0E6);
  static const Color backgroundInlima = Color(0xFFFFFFFF);
  static const Color darkBackgroundInlima = Color(0xFF121212);
  static const Color textColorWhite = Color(0xFFFFFFFF);
  static const Color textColorBlack = Color(0xFF000000);
  static const Color textColorLightGray = Color(0xFFA9A9A9);
  static const Color accentColorInlima = Color(0xFFBB86FC);

  static var primaryColor;

  static Color getColorText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textColorBlack
        : textColorWhite;
  }
}
