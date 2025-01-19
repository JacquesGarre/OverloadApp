import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/widgets/workout/workout_exercise_form_widget.dart';

class EditWorkoutExercisePage extends StatefulWidget {
  final WorkoutExercise workoutExercise;

  const EditWorkoutExercisePage({
    super.key,
    required this.workoutExercise,
  });

  static const String title = 'Edit workout exercise';

  @override
  State<EditWorkoutExercisePage> createState() => _EditWorkoutExercisePageState();
}

class _EditWorkoutExercisePageState extends State<EditWorkoutExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: EditWorkoutExercisePage.title,
      ),
      body: SingleChildScrollView(
        child: WorkoutExerciseFormWidget(
          index: widget.workoutExercise.index(),
          workoutExercise: widget.workoutExercise,
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
