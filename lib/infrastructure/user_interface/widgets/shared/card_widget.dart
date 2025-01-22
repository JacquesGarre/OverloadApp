import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_header_widget.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? child;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CardWidget({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.title,
    this.subtitle,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: AppColorScheme.lightBackground,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CardHeaderWidget(
          title: title,
          subtitle: subtitle,
          onEdit: onEdit,
          onDelete: onDelete,
          child: child,
        ),
      ),
    );
  }
}
