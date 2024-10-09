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
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.tertiaryColorInlima, // Dark blue background
        selectedItemColor: Colors.white, // White for selected icons
        unselectedItemColor: Colors.white54, // Slightly transparent white for unselected icons
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

  // Define the dark theme
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColorInlima,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.blackInlima,
        foregroundColor: AppColors.textColorWhite,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.blackInlima, // Dark background
        selectedItemColor: AppColors.accentColorInlima, // Accent color for selected icons
        unselectedItemColor: Colors.white54, // Slightly transparent white for unselected icons
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
