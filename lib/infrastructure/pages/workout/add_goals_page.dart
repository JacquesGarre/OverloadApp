import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goal.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/widgets/workout/goals_timeline_widget.dart';

class AddGoalsPage extends StatefulWidget {
  final Exercise exercise;
  final Sets sets;

  const AddGoalsPage({super.key, required this.exercise, required this.sets});

  static const String title = 'Set your goals';

  @override
  State<AddGoalsPage> createState() => _AddGoalsPageState();
}

class _AddGoalsPageState extends State<AddGoalsPage> {
  final GlobalKey<GoalsTimelineWidgetState> goalsKey =
      GlobalKey<GoalsTimelineWidgetState>();

  _handleAddExercise() {
    /*
      final Exercise _exercise;
      final Sets _sets;
      final Notes? _notes;
      final Goals? _goals;
    */
    Goals? goals = goalsKey.currentState?.goals;
    if (goals != null) {
      Logger().e("[EXERCISE] ${widget.exercise}");
      Logger().e("[SETS] ${widget.sets}");
      Logger().e("[GOALS] $goals"); // WORKS
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: AddGoalsPage.title,
      ),
      body: SingleChildScrollView(
        child: GoalsTimelineWidget(
          key: goalsKey,
          exercise: widget.exercise,
          sets: widget.sets,
        ),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: SizedBox(
        height: 40.0,
        child: FloatingActionButton.extended(
          onPressed: _handleAddExercise,
          label: const Text("Add exercise"),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
