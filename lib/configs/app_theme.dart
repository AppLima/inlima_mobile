import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColorInlima,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColorInlima,
        foregroundColor: AppColors.textColorWhite,
      ),
      textTheme: TextTheme(
        displaySmall: TextStyle(
          color: AppColors.textColorBlack,
          fontSize: 32.0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColorInlima,
          foregroundColor: AppColors.textColorWhite,
        ),
      ),
      scaffoldBackgroundColor: AppColors.textColorWhite,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColorInlima,
        secondary: AppColors.secondaryColorInlima,
      ),
    );
  }

  // Define el tema oscuro
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColorInlima,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.blackInlima,
        foregroundColor: AppColors.textColorWhite,
      ),
      textTheme: TextTheme(
        displaySmall: TextStyle(
          color: AppColors.textColorWhite,
          fontSize: 32.0,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textColorLightGray,
          fontSize: 16.0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentColorInlima,
          foregroundColor: AppColors.textColorWhite,
        ),
      ),
      scaffoldBackgroundColor: AppColors.darkBackgroundInlima,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryColorInlima,
        secondary: AppColors.accentColorInlima,
      ),
    );
  }
}
