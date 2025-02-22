import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_header_widget.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? headerChild;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onStart;
  final List<Widget>? children;
  final List<Widget>? menuChildren;

  const CardWidget({
    super.key,
    required this.title,
    this.onEdit,
    this.onDelete,
    this.onStart,
    this.subtitle,
    this.headerChild,
    this.children,
    this.menuChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: AppColorScheme.lightBackground,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardHeaderWidget(
              title: title,
              subtitle: subtitle,
              onEdit: onEdit,
              onDelete: onDelete,
              onStart: onStart,
              menuChildren: menuChildren,
              child: headerChild,
            ),
            if (children != null)
              Divider(
                color: AppColorScheme.primary,
              ),
            if (children != null)
              const SizedBox(
                height: 4.0,
              ),
            if (children != null)
              ...children!.map(
                (widget) {
                  return widget;
                },
              ),
          ],
        ),
      ),
    );
  }
}
