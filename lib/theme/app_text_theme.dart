import 'package:flutter/material.dart';

const _primaryFontFamily = "MyriadPro";

const TextTheme appTextTheme = TextTheme(
  displayLarge: TextStyle( // Heading 1
    fontFamily: _primaryFontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 42 / 28,
  ),
  displayMedium: TextStyle( // Heading 2
    fontFamily: _primaryFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 36 / 24,
  ),
  displaySmall: TextStyle( // Heading 3
    fontFamily: _primaryFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 30 / 20,
  ),
  headlineMedium: TextStyle( // Heading 4
    fontFamily: _primaryFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 28 / 18,
  ),
  bodyLarge: TextStyle( // Body Large
    fontFamily: _primaryFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 28 / 18,
  ),
  bodyMedium: TextStyle( // Body
    fontFamily: _primaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  ),
  bodySmall: TextStyle( // Body Small
    fontFamily: _primaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 22 / 14,
  ),
  labelLarge: TextStyle( // Caption
    fontFamily: _primaryFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 18 / 12,
  ),
  titleSmall: TextStyle( // Small Title
    fontFamily: _primaryFontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 16 / 10,
  ),
);
