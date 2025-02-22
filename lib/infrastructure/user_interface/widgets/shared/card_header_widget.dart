import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_subtitle_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_title_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/delete_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/edit_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/start_button_widget.dart';

class CardHeaderWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? child;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onStart;
  final List<Widget>? menuChildren;

  const CardHeaderWidget({
    super.key,
    required this.title,
    this.onEdit,
    this.onDelete,
    this.onStart,
    this.subtitle,
    this.child,
    this.menuChildren,
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
            if (onEdit != null) EditButtonWidget(onPressed: onEdit!),
            if (onDelete != null) DeleteButtonWidget(onPressed: onDelete!),
            if (onStart != null) StartButtonWidget(onPressed: onStart!),
            if (menuChildren != null)
              MenuAnchor(
                builder: (
                  BuildContext context,
                  MenuController controller,
                  Widget? child,
                ) {
                  return IconButton(
                    color: AppColorScheme.primary,
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: const Icon(Icons.more_horiz),
                    tooltip: 'Show menu',
                  );
                },
                menuChildren: menuChildren!,
              ),
          ],
        ),
      ],
    );
  }
}
