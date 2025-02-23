import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/config/modal_action_button_config.dart';
import 'package:overload/infrastructure/user_interface/pages/session/new_session_page.dart';
import 'package:overload/infrastructure/user_interface/pages/session/session_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/modal_widget.dart';

void showCurrentSessionModal({
  required BuildContext context,
  required SessionProvider sessionProvider,
}) {
  showModal(
    context: context,
    title: "Session in progress",
    content: "You have an active session on going.",
    actionButtons: [
      ModalActionButtonConfig(
        text: "Continue the session",
        backgroundColor: AppColorScheme.lightBackground,
        textColor: AppColorScheme.primary,
        onPressed: () async {
          Navigator.pop(context);
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SessionPage(
                sessionId: sessionProvider.currentSession!.id(),
              ),
            ),
          );
        },
      ),
      ModalActionButtonConfig(
        text: "Delete and start a new session",
        backgroundColor: AppColorScheme.lightBackground,
        textColor: AppColorScheme.error,
        onPressed: () async {
          Navigator.pop(context);
          await sessionProvider.deleteCurrentSession();
          if (!context.mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewSessionPage(),
            ),
          );
        },
      ),
    ],
  );
}
