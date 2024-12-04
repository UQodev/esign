import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFF6F6F6);
  static const Color background = Color(0xFFFAFAFA);
  static const Color secondary = Color(0xFFC7EEFF);
  static const Color textDark = Color(0xFF1D242B);

  static const Color primaryLight = Color(0xFF3391CD);
  static const Color primaryDark = Color(0xFF005D999);

  static ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        background: background,
        surface: secondary,
        onSurface: textDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: background,
        ),
      ),
    );
  }
}
