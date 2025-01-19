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

class GoalsPage extends StatefulWidget {

  final WorkoutExerciseIndex index;
  final Exercise exercise;
  final Sets sets;
  final Notes? notes;
  final WorkoutExercise? workoutExercise;

  const GoalsPage({
    super.key,
    required this.index,
    required this.exercise,
    required this.sets,
    this.notes,
    this.workoutExercise
  });

  static const String title = 'Set your goals';

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final GlobalKey<GoalsTimelineWidgetState> goalsKey =
      GlobalKey<GoalsTimelineWidgetState>();

  WorkoutExercise? workoutExercise;

  @override
  initState() {
    super.initState();
    if (widget.workoutExercise != null) {
      workoutExercise = widget.workoutExercise;
    }
  }

  // TODO: Refacto ce widget


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

  _handleUpdateWorkoutExercise() {
    Goals? goals = goalsKey.currentState?.goals;
    setState(() {
      workoutExercise = WorkoutExercise(
        index: workoutExercise!.index(),
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
        title: GoalsPage.title,
      ),
      body: SingleChildScrollView(
        child: GoalsTimelineWidget(
          key: goalsKey,
          exercise: widget.exercise,
          sets: widget.sets,
          existingGoals: widget.workoutExercise?.goals()!,
        ),
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: SizedBox(
        height: 40.0,
        child: FloatingActionButton.extended(
          onPressed: widget.workoutExercise != null ? _handleUpdateWorkoutExercise : _handleAddWorkoutExercise,
          label: widget.workoutExercise != null ?  const Text("Update exercise") : const Text("Add exercise"),
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
