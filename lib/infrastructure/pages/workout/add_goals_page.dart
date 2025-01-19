import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/widgets/workout/goals_timeline_widget.dart';

class AddGoalsPage extends StatefulWidget {

  final Exercise exercise;
  final Sets sets;

  const AddGoalsPage({
    super.key,
    required this.exercise,
    required this.sets    
  });

  static const String title = 'Set your goals'; // TODO: Center title here (And maybe everywhere on "subpages"?)

  @override
  State<AddGoalsPage> createState() => _AddGoalsPageState();
}

class _AddGoalsPageState extends State<AddGoalsPage> {
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
        title: AddGoalsPage.title,
      ),
      body: SingleChildScrollView(
        child: GoalsTimelineWidget(
          exercise: widget.exercise,
          sets: widget.sets,
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
