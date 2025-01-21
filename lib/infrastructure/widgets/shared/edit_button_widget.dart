import 'package:flutter/material.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class EditButtonWidget extends StatelessWidget {

  final VoidCallback onPressed;

  const EditButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      color: AppColorScheme.primary,
      onPressed: onPressed,
    );
  }
}
