import 'package:flutter/material.dart';

class AppColorScheme {

  static Color background = const Color(0xFF0D1B2A); 
  static Color onBackground = Colors.white;
  static Color lightBackground = const Color(0xFF1B263B); 
  static Color onLightBackground = const Color(0xFF778DA9); 
  static Color primary = const Color(0xFF03A9F4);
  static Color onPrimary = Colors.white;
  static Color secondary = const Color(0xFF004080);
  static Color onSecondary = Colors.white;
  static Color error = Colors.red;
  static Color onError = Colors.white;

  static ColorScheme get colorScheme {
    return ColorScheme(
      brightness: Brightness.light,
      primary: primary, 
      onPrimary: onPrimary, 
      secondary: secondary, 
      onSecondary: onSecondary, 
      surface: background,
      onSurface: onBackground, 
      error: error,
      onError: onError,
    );
  }
}
