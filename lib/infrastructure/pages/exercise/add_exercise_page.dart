import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/exercise/exercise_provider.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_form_widget.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:provider/provider.dart';

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({super.key});

  static const String title = 'Add an exercise';

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {

  void _handleFormSubmit(Map<String, dynamic> formData) {
    ExerciseProvider exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    exerciseProvider.addExercise(formData);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: AddExercisePage.title),
      body: ExerciseFormWidget(
        onSubmit: _handleFormSubmit,
      ),
    );
  }
}
