import 'package:flutter/material.dart';
import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/workout_exercise_form_widget.dart';

class AddWorkoutExercisePage extends StatelessWidget {
  final Id workoutId;
  final WorkoutExerciseIndex index;

  const AddWorkoutExercisePage(
      {super.key, required this.workoutId, required this.index});

  static const String title = 'Add exercise to your workout';

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      title: title,
      child: SingleChildScrollView(
        child: WorkoutExerciseFormWidget(
          workoutId: workoutId,
          index: index,
        ),
      ),
    );
  }
}
