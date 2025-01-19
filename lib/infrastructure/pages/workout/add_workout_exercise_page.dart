import 'package:flutter/material.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/widgets/workout/workout_exercise_form_widget.dart';

class AddWorkoutExercisePage extends StatefulWidget {
  const AddWorkoutExercisePage({super.key});

  static const String title = 'Add exercise to your workout';

  @override
  State<AddWorkoutExercisePage> createState() => _AddWorkoutExercisePageState();
}

class _AddWorkoutExercisePageState extends State<AddWorkoutExercisePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(
        title: AddWorkoutExercisePage.title,
      ),
      body: SingleChildScrollView(
        child: WorkoutExerciseFormWidget(),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
