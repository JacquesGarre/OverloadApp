import 'package:flutter/material.dart';
import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/workout_exercises.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/workout_provider.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/workout_form_widget.dart';
import 'package:provider/provider.dart';

class AddWorkoutPage extends StatelessWidget {
  const AddWorkoutPage({super.key});

  static const String title = 'New workout';

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(
      context,
      listen: false,
    );
    return PageWidget(
      title: title,
      child: SingleChildScrollView(
        child: WorkoutFormWidget(
          onSubmit: (
            String name,
            String? notes,
            WorkoutExercises workoutExercises,
          ) async {
            try {
              await workoutProvider.addWorkout(
                name,
                notes,
                workoutExercises,
              );
              if (!context.mounted) return;
              Navigator.pop(context, true);
            } catch (e) {
              ExceptionHandler().handleException(context, e);
            }
          },
        ),
      ),
    );
  }
}
