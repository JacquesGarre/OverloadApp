import 'package:flutter/material.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/widgets/workout/workout_form_widget.dart';

class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({super.key});

  static const String title = 'New workout';

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  void _handleCreate(Map<String, dynamic> formData) async {
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
        title: AddWorkoutPage.title,
      ),
      body: WorkoutFormWidget(
        onSubmit: _handleCreate,
      ),
    );
  }
}
