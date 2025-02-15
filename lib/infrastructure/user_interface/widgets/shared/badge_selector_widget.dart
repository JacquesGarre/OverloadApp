import 'package:flutter/material.dart';

class BadgeSelectorWidget extends StatefulWidget {
  final String label;
  final List<String> items;
  final List<String> selectedItems;
  final String? errorMessage;

  const BadgeSelectorWidget({
    super.key,
    required this.label,
    required this.items,
    required this.selectedItems,
    this.errorMessage,
  });

  @override
  BadgeSelectorWidgetState createState() => BadgeSelectorWidgetState();
}

class BadgeSelectorWidgetState extends State<BadgeSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 2),
        Wrap(
          spacing: 8.0,
          runSpacing: 0.0,
          children: widget.items.map((item) {
            final isSelected = widget.selectedItems.contains(item);
            return FilterChip(
              padding: const EdgeInsets.all(0.0),
              label: Text(
                item,
                style: TextStyle(fontSize: 13.0),
              ),
              selected: isSelected,
              onSelected: (_) {
                if (widget.selectedItems.contains(item)) {
                  widget.selectedItems.remove(item);
                } else {
                  widget.selectedItems.add(item);
                }
                setState(() {});
              },
              selectedColor: Theme.of(context).colorScheme.primary,
              checkmarkColor: Colors.white,
            );
          }).toList(),
        ),
        if (widget.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorMessage!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
