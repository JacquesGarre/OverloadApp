import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_subtitle_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_title_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/delete_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/edit_button_widget.dart';

class CardHeaderWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? child;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CardHeaderWidget({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.title,
    this.subtitle,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitleWidget(text: title),
              const SizedBox(height: 5.0),
              if (subtitle != null) CardSubtitleWidget(text: subtitle!),
              const SizedBox(height: 5.0),
              if (child != null) child!,
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            EditButtonWidget(onPressed: onEdit),
            DeleteButtonWidget(onPressed: onDelete),
          ],
        ),
      ],
    );
  }
}
