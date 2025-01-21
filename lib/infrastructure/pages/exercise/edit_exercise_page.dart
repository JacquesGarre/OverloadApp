import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_form_widget.dart';
import 'package:overload/infrastructure/widgets/shared/page_widget.dart';
import 'package:provider/provider.dart';

class EditExercisePage extends StatelessWidget {
  final Exercise exercise;

  static const String title = 'Edit Exercise';

  const EditExercisePage({super.key, required this.exercise});

  static Future<void> _handleSubmit(
    BuildContext context,
    Exercise exercise,
    Map<String, dynamic> formData,
  ) async {
    try {
      final exerciseProvider = Provider.of<ExerciseProvider>(
        context,
        listen: false,
      );
      await exerciseProvider.updateExercise(exercise, formData);
      if (!context.mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      ExceptionHandler().handleException(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      title: title,
      child: ExerciseFormWidget(
        exercise: exercise,
        onSubmit: (formData) => _handleSubmit(context, exercise, formData),
      ),
    );
  }
}
