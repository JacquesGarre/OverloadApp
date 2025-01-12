import 'package:flutter/material.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'Poppins',
      textTheme: const TextTheme(),
      colorScheme: AppColorScheme.colorScheme,
      useMaterial3: true,
      navigationBarTheme: NavigationBarThemeData(
        height: 60,
        backgroundColor: AppColorScheme.lightBackground,
        indicatorColor: AppColorScheme.lightBackground,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              size: 25,
              color: AppColorScheme.primary,
            );
          }
          return IconThemeData(
            size: 25,
            color: AppColorScheme.onLightBackground,
          );
        }),
        surfaceTintColor: Colors.transparent,
        overlayColor: const WidgetStatePropertyAll(
          Colors.transparent,
        ),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColorScheme.primary,
            );
          }
          return TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColorScheme.onLightBackground,
          );
        }),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
