import 'package:flutter/material.dart';

class CardTitleWidget extends StatelessWidget {
  final String text;

  const CardTitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
