import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/infrastructure/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/widgets/workout/workout_exercise_form_widget.dart';

class AddWorkoutExercisePage extends StatelessWidget {
  final WorkoutExerciseIndex index;

  const AddWorkoutExercisePage({super.key, required this.index});

  static const String title = 'Add exercise to your workout';

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      title: title,
      child: WorkoutExerciseFormWidget(
        index: index,
      ),
    );
  }
}
