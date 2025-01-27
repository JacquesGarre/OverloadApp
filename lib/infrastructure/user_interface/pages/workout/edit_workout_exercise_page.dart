import 'package:flutter/material.dart';
import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/workout_exercise_form_widget.dart';

class EditWorkoutExercisePage extends StatelessWidget {
  final Id workoutId;
  final WorkoutExercise workoutExercise;

  static const String title = 'Edit workout exercise';

  const EditWorkoutExercisePage({
    super.key,
    required this.workoutId,
    required this.workoutExercise,
  });

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      title: title,
      child: WorkoutExerciseFormWidget(
        workoutId: workoutId,
        index: workoutExercise.index(),
        workoutExercise: workoutExercise,
      ),
    );
  }
}
