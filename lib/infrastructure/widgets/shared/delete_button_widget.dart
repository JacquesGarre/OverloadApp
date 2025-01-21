import 'package:flutter/material.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class DeleteButtonWidget extends StatelessWidget {

  final VoidCallback onPressed;

  const DeleteButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      color: AppColorScheme.primary,
      onPressed: onPressed,
    );
  }
}
