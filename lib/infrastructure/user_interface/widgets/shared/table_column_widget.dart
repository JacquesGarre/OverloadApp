import 'package:flutter/material.dart';

class TableColumnWidget extends StatelessWidget {
  final double rowHeight;
  final String text;

  const TableColumnWidget({
    super.key,
    required this.rowHeight,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: SizedBox(
        height: rowHeight,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
