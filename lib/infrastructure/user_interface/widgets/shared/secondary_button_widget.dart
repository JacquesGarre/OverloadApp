import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class SecondaryButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SecondaryButtonWidget(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          AppColorScheme.lightBackground,
        ),
        foregroundColor: WidgetStatePropertyAll(
          AppColorScheme.primary,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
