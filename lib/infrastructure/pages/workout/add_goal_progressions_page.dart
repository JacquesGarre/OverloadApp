import 'package:flutter/material.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/widgets/workout/goal_progressions_form_widget.dart';

class AddGoalProgressionsPage extends StatefulWidget {
  const AddGoalProgressionsPage({super.key});

  static const String title = 'After reaching your goal'; // TODO: Center title here (And maybe everywhere on "subpages"?)

  @override
  State<AddGoalProgressionsPage> createState() => _AddGoalProgressionsPageState();
}

class _AddGoalProgressionsPageState extends State<AddGoalProgressionsPage> {
  void _handleAdd(Map<String, dynamic> formData) async {
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
        title: AddGoalProgressionsPage.title,
      ),
      body: SingleChildScrollView(
        child: GoalProgressionsFormWidget(
          onSubmit: _handleAdd,
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
