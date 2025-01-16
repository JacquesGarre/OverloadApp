import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/workout_exercise.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_dropdown_widget.dart';

class WorkoutExerciseFormWidget extends StatefulWidget {
  final WorkoutExercise? workoutExercise;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const WorkoutExerciseFormWidget({
    super.key,
    this.workoutExercise,
    required this.onSubmit,
  });

  @override
  State<WorkoutExerciseFormWidget> createState() => _WorkoutExerciseFormWidgetState();
}

class _WorkoutExerciseFormWidgetState extends State<WorkoutExerciseFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submitForm() {
    final isFormValid = _formKey.currentState!.validate();

    if (isFormValid) {
      widget.onSubmit({});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExerciseDropdownWidget(
              onChange: (Exercise? exercise) {
                Logger().i("Exercise selected : $exercise");
              }
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(
                    AppColorScheme.onPrimary,
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    AppColorScheme.primary,
                  ),
                ),
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
