import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_text_theme.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.neutralWhite,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary02,
    onPrimary: AppColors.neutralWhite,
    secondary: AppColors.secondary02,
    onSecondary: AppColors.neutral01,
    background: AppColors.neutral05,
    onBackground: AppColors.neutral01,
    surface: AppColors.neutralWhite,
    onSurface: AppColors.neutral01,
    error: AppColors.error02,
    onError: AppColors.neutralWhite,
  ),
  textTheme: appTextTheme,
/*   elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary02,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary02,
      side: const BorderSide(color: AppColors.primary02),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.neutral04),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary02),
    ),
    labelStyle: const TextStyle(color: AppColors.neutral03),
  ), */
);
