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
  void _handleAdd(Map<String, dynamic> formData) async {
    // try {
    //   ExerciseProvider exerciseProvider = Provider.of<ExerciseProvider>(
    //     context,
    //     listen: false,
    //   );
    //   await exerciseProvider.addExercise(formData);
    //   if (!mounted) return;
    //   Navigator.pop(context);
    // } catch (e) {
    //   ExceptionHandler().handleException(context, e);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: AddWorkoutExercisePage.title,
      ),
      body: SingleChildScrollView(
        child: WorkoutExerciseFormWidget(
          onSubmit: _handleAdd,
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
