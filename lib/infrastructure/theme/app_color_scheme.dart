import 'package:flutter/material.dart';

class AppColorScheme {
  static ColorScheme get midnightOcean {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF004080), 
      onPrimary: Colors.white, 
      secondary: Color(0xFF0073E6), 
      onSecondary: Colors.white, 
      surface: Color(0xFF001F3F),
      onSurface: Colors.white, 
      error: Colors.red,
      onError: Colors.white,
    );
  }
}
