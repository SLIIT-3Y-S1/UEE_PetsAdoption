import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';


class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(fontFamily: 'Roboto', fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      headline2: TextStyle(fontFamily: 'Roboto', fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      bodyText1: TextStyle(fontFamily: 'Lato', fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
      bodyText2: TextStyle(fontFamily: 'Lato', fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textSecondary),
      button: TextStyle(fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.buttonText),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBackground,
      border: OutlineInputBorder(),
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accent).copyWith(background: AppColors.background),
  );
}
