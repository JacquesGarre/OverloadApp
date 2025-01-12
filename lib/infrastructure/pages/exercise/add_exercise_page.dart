import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_form_widget.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({super.key});

  static const String title = 'Add an exercise';

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  void _handleFormSubmit(Map<String, dynamic> formData) {
    AddExerciseCommand command = AddExerciseCommand(
      name: formData["name"],
      units: formData["units"],
    );
    Logger().i(command);
    //Navigator.pop(context, formData);
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
