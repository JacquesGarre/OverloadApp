import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/workout_form_widget.dart';

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
