import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/widgets/workout/goals_timeline_widget.dart';

class AddGoalsPage extends StatefulWidget {

  final WorkoutExerciseIndex index;
  final Exercise exercise;
  final Sets sets;
  final Notes? notes;

  const AddGoalsPage({
    super.key,
    required this.index,
    required this.exercise,
    required this.sets,
    this.notes,
  });

  static const String title = 'Set your goals';

  @override
  State<AddGoalsPage> createState() => _AddGoalsPageState();
}

class _AddGoalsPageState extends State<AddGoalsPage> {
  final GlobalKey<GoalsTimelineWidgetState> goalsKey =
      GlobalKey<GoalsTimelineWidgetState>();

  WorkoutExercise? workoutExercise;

  _handleAddWorkoutExercise() {
    Goals? goals = goalsKey.currentState?.goals;
    setState(() {
      workoutExercise = WorkoutExercise(
        index: widget.index,
        exercise: widget.exercise,
        sets: widget.sets,
        notes: widget.notes,
        goals: goals,
      );
    });
    Navigator.pop(context, workoutExercise);
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
          onPressed: _handleAddWorkoutExercise,
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
