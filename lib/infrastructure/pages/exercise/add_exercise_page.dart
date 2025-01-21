import 'package:flutter/material.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_form_widget.dart';
import 'package:overload/infrastructure/widgets/shared/page_widget.dart';
import 'package:provider/provider.dart';

class AddExercisePage extends StatelessWidget {
  const AddExercisePage({super.key});

  static const String title = 'New Exercise';

  @override
  Widget build(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(
      context,
      listen: false,
    );
    return PageWidget(
      title: title,
      child: ExerciseFormWidget(
        onSubmit: (formData) async {
          try {
            await exerciseProvider.addExercise(formData);
            if (!context.mounted) return;
            Navigator.pop(context, true);
          } catch (e) {
            ExceptionHandler().handleException(context, e);
          }
        },
      ),
    );
  }
}
