import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/core/constants/text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    
    textTheme: TextTheme(
      displayLarge: TextStyles.headlineLarge.copyWith(color: AppColors.textPrimary),
      displayMedium: TextStyles.headlineMedium.copyWith(color: AppColors.textPrimary),
      bodySmall: TextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
      labelMedium: TextStyles.labelMedium.copyWith(color: AppColors.textSecondary),
      labelSmall: TextStyles.labelSmall.copyWith(color: AppColors.textSecondary),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: false,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentYellow, width: 2.0),
      ),
    ), // textfields decorations
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(surface: AppColors.background)
        .copyWith(onError: AppColors.error),
  );
}
