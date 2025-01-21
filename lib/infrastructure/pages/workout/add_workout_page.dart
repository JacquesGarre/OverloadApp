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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(
        title: AddWorkoutPage.title,
      ),
      body: SingleChildScrollView(
        child: WorkoutFormWidget(),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
