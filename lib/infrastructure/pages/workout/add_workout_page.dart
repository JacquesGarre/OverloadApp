import 'package:flutter/material.dart';
import 'package:overload/infrastructure/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/widgets/workout/workout_form_widget.dart';

class AddWorkoutPage extends StatelessWidget {
  const AddWorkoutPage({super.key});

  static const String title = 'New workout';

  @override
  Widget build(BuildContext context) {
    return const PageWidget(
      title: title,
      child: WorkoutFormWidget(),
    );
  }
}
