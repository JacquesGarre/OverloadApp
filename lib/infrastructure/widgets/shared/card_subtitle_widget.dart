import 'package:flutter/material.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class CardSubtitleWidget extends StatelessWidget {
  final String text;

  const CardSubtitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColorScheme.onLightBackground,
      ),
    );
  }
}
