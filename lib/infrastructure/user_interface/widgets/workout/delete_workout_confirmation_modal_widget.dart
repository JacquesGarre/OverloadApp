import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/workout_provider.dart';
import 'package:overload/infrastructure/user_interface/config/modal_action_button_config.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/modal_widget.dart';
import 'package:provider/provider.dart';

void showDeleteWorkoutConfirmationModal({
  required BuildContext context,
  required WorkoutProvider workoutProvider,
  required Workout workout,
}) {
  showModal(
    context: context,
    title: "Delete workout",
    content:
        "Are you sure you want to delete this workout? This action cannot be undone.",
    actionButtons: [
      ModalActionButtonConfig(
        text: "Delete it",
        backgroundColor: AppColorScheme.lightBackground,
        textColor: AppColorScheme.error,
        onPressed: () async {
          Navigator.pop(context);
          try {
            WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(
              context,
              listen: false,
            );
            await workoutProvider.deleteWorkout(workout);
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
