import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_form_widget.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:provider/provider.dart';

class UpdateExercisePage extends StatefulWidget {
  final Exercise exercise;

  static const String title = 'Edit exercise';

  const UpdateExercisePage({super.key, required this.exercise});

  @override
  State<UpdateExercisePage> createState() => _UpdateExercisePageState();
}

class _UpdateExercisePageState extends State<UpdateExercisePage> {
  void _handleUpdate(Map<String, dynamic> formData) async {
    try {
      ExerciseProvider exerciseProvider = Provider.of<ExerciseProvider>(
        context,
        listen: false,
      );
      await exerciseProvider.updateExercise(
        widget.exercise,
        formData,
      );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      ExceptionHandler().handleException(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: UpdateExercisePage.title,
      ),
      body: ExerciseFormWidget(
        exercise: widget.exercise,
        onSubmit: _handleUpdate,
      ),
    );
  }
}
