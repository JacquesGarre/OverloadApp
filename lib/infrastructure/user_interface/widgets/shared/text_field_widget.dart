import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final int? maxLines;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColorScheme.lightBackground,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
          maxLines: maxLines
        ),
      ],
    );
  }
}
