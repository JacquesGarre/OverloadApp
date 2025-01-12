import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/infrastructure/providers/exercise/exercise_provider.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_form_widget.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:provider/provider.dart';

class UpdateExercisePage extends StatefulWidget {

  final Exercise exercise;

  const UpdateExercisePage({super.key, required this.exercise});

  @override
  State<UpdateExercisePage> createState() => _UpdateExercisePageState();
}

class _UpdateExercisePageState extends State<UpdateExercisePage> {

  void _handleUpdate(Map<String, dynamic> formData) {
    ExerciseProvider exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    exerciseProvider.updateExercise(widget.exercise, formData);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Update ${widget.exercise.name.value}'),
      body: ExerciseFormWidget(
        exercise: widget.exercise,
        onSubmit: _handleUpdate,
      ),
    );
  }
}
