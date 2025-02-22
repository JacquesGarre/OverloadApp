import 'package:flutter/material.dart';

class FloatingCenteredButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? heroTag;

  const FloatingCenteredButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      width: double.infinity,
      child: FloatingActionButton.extended(
        heroTag: heroTag,
        onPressed: onPressed,
        label: Text(text),
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        foregroundColor: foregroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
