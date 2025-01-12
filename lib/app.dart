import 'package:flutter/material.dart';
import 'package:overload/infrastructure/layout/app_layout.dart';
import 'package:overload/infrastructure/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const String appTitle = 'Overload';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: AppTheme.theme,
      home: const AppLayout(),
    );
  }
}
