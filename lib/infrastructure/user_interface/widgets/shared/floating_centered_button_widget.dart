import 'package:flutter/material.dart';

class FloatingCenteredButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const FloatingCenteredButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        label: Text(text),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
