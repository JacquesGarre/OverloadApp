import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/widgets/workout/workout_exercise_form_widget.dart';

class AddWorkoutExercisePage extends StatefulWidget {
  final WorkoutExerciseIndex index;

  const AddWorkoutExercisePage({
    super.key,
    required this.index,
  });

  static const String title = 'Add exercise to your workout';

  @override
  State<AddWorkoutExercisePage> createState() => _AddWorkoutExercisePageState();
}

class _AddWorkoutExercisePageState extends State<AddWorkoutExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: AddWorkoutExercisePage.title,
      ),
      body: SingleChildScrollView(
        child: WorkoutExerciseFormWidget(
          index: widget.index,
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
