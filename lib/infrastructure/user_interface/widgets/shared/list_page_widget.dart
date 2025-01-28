import 'package:flutter/material.dart';

class ListPageWidget extends StatelessWidget {
  final Widget list;
  final VoidCallback? onFloatingActionButtonPressed;
  final IconData? floatingActionButtonIcon;

  const ListPageWidget({super.key, required this.list, this.onFloatingActionButtonPressed, this.floatingActionButtonIcon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            12.0,
            0,
            12.0,
            0,
          ),
          child: list,
        ),
        if (onFloatingActionButtonPressed != null)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: onFloatingActionButtonPressed,
              child: Icon(floatingActionButtonIcon ?? Icons.add),
            ),
          ),
      ],
    );
  }
}
