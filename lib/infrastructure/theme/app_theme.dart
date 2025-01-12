import 'package:flutter/material.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'Poppins',
      textTheme: const TextTheme(),
      colorScheme: AppColorScheme.midnightOcean,
      useMaterial3: true,
      navigationBarTheme: const NavigationBarThemeData(
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
