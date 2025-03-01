import 'package:flutter/material.dart';

class ListPageWidget extends StatelessWidget {
  final ListView list;
  final int itemsCount;
  final String emptyListText;
  final VoidCallback? onFloatingActionButtonPressed;
  final IconData? floatingActionButtonIcon;

  const ListPageWidget({
    super.key,
    required this.itemsCount,
    required this.emptyListText,
    required this.list,
    this.onFloatingActionButtonPressed,
    this.floatingActionButtonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        itemsCount == 0
            ? Center(
                child: Text(emptyListText),
              )
            : Padding(
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
