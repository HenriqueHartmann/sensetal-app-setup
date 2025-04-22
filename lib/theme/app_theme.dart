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
);
