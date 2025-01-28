import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class StartButtonWidget extends StatelessWidget {

  final VoidCallback onPressed;

  const StartButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40.0,
      icon: const Icon(Icons.play_arrow),
      color: AppColorScheme.primary,
      onPressed: onPressed,
    );
  }
}
