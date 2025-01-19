import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goal.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/set/set.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/widgets/workout/goals_timeline_widget.dart';

class AddGoalsPage extends StatefulWidget {
  final Exercise exercise;
  final Sets sets;

  const AddGoalsPage({super.key, required this.exercise, required this.sets});

  static const String title =
      'Set your goals'; // TODO: Center title here (And maybe everywhere on "subpages"?)

  @override
  State<AddGoalsPage> createState() => _AddGoalsPageState();
}

class _AddGoalsPageState extends State<AddGoalsPage> {
  
  final GlobalKey<GoalsTimelineWidgetState> goalsKey = GlobalKey<GoalsTimelineWidgetState>();

  _handleAddExercise() {
    Goals? goals = goalsKey.currentState?.goals;
    if(goals != null) {
      for(Goal goal in goals.value) {
        Logger().i(goal.toString());
      }
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
