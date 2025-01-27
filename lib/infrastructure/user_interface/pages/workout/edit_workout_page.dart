import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercises.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/workout_provider.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/workout_form_widget.dart';
import 'package:provider/provider.dart';

class EditWorkoutPage extends StatelessWidget {

  final Workout workout;

  const EditWorkoutPage({super.key, required this.workout});

  static const String title = 'Edit workout';

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(
      context,
      listen: false,
    );
    return PageWidget(
      title: title,
      child: WorkoutFormWidget(
        workout: workout,
        onSubmit: (
          String name,
          String? notes,
          WorkoutExercises workoutExercises,
        ) async {
          try {
            await workoutProvider.updateWorkout(
              workout.id(),
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
    );
  }
}
