import 'package:flutter/material.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/exercise/exercise_provider.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_form_widget.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:provider/provider.dart';

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({super.key});

  static const String title = 'Add exercise';

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  void _handleCreate(Map<String, dynamic> formData) async {
    try {
      ExerciseProvider exerciseProvider = Provider.of<ExerciseProvider>(
        context,
        listen: false,
      );
      await exerciseProvider.addExercise(formData);
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
        title: AddExercisePage.title,
      ),
      body: ExerciseFormWidget(
        onSubmit: _handleCreate,
      ),
    );
  }
}
