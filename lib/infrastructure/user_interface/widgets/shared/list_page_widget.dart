import 'package:flutter/material.dart';

class ListPageWidget extends StatelessWidget {
  final Widget list;
  final VoidCallback? onAdd;
  final IconData? fabIcon;

  const ListPageWidget({super.key, required this.list, this.onAdd, this.fabIcon});

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
        if (onAdd != null)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: onAdd,
              child: Icon(fabIcon ?? Icons.add),
            ),
          ),
      ],
    );
  }
}
