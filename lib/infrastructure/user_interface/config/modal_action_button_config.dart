import 'package:flutter/material.dart';

class ModalActionButtonConfig {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Future<void> Function() onPressed;

  ModalActionButtonConfig({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });
}
