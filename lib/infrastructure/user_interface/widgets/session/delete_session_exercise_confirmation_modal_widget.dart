import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/config/modal_action_button_config.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/modal_widget.dart';
import 'package:provider/provider.dart';

void showDeleteSessionExerciseConfirmationModal({
  required BuildContext context,
  required SessionProvider sessionProvider,
  required Session session,
  required SessionExercise sessionExercise,
}) {
  showModal(
    context: context,
    title: "Remove exercise",
    content:
        "Are you sure you want to remove this exercise from your current session? This action cannot be undone.",
    actionButtons: [
      ModalActionButtonConfig(
        text: "Remove",
        backgroundColor: AppColorScheme.lightBackground,
        textColor: AppColorScheme.error,
        onPressed: () async {
          Navigator.pop(context);
          try {
            SessionProvider sessionProvider = Provider.of<SessionProvider>(
              context,
              listen: false,
            );
            await sessionProvider.removeSessionExercise(session.id(), sessionExercise);
          } catch (e) {
            if (!context.mounted) return;
            ExceptionHandler().handleException(context, e);
          }
        },
      ),
      ModalActionButtonConfig(
        text: "Cancel",
        backgroundColor: AppColorScheme.lightBackground,
        textColor: AppColorScheme.primary,
        onPressed: () async {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
