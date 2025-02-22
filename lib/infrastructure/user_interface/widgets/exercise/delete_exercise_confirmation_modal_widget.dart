import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/user_interface/config/modal_action_button_config.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/modal_widget.dart';
import 'package:provider/provider.dart';

void showDeleteExerciseConfirmationModal({
  required BuildContext context,
  required ExerciseProvider exerciseProvider,
  required Exercise exercise,
}) {
  showModal(
    context: context,
    title: "Delete exercise",
    content:
        "Are you sure you want to delete this exercise? This action cannot be undone.",
    actionButtons: [
      ModalActionButtonConfig(
        text: "Delete it",
        backgroundColor: AppColorScheme.lightBackground,
        textColor: AppColorScheme.error,
        onPressed: () async {
          Navigator.pop(context);
          try {
            ExerciseProvider exerciseProvider = Provider.of<ExerciseProvider>(
              context,
              listen: false,
            );
            await exerciseProvider.deleteExercice(exercise);
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
