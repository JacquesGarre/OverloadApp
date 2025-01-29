import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/config/modal_action_button_config.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class ModalWidget extends StatelessWidget {
  final String title;
  final String content;
  final List<ModalActionButtonConfig> actionButtons;

  const ModalWidget({
    super.key,
    required this.title,
    required this.content,
    required this.actionButtons,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColorScheme.onLightBackground,
          fontSize: 13.0,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...actionButtons.map((actionButton) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        actionButton.backgroundColor,
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        actionButton.textColor,
                      ),
                    ),
                    onPressed: actionButton.onPressed,
                    child: Text(actionButton.text),
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}

void showModal({
  required BuildContext context,
  required String title,
  required String content,
  required List<ModalActionButtonConfig> actionButtons,
}) {
  if (!context.mounted) return;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ModalWidget(
        title: title,
        content: content,
        actionButtons: actionButtons,
      );
    },
  );
}
