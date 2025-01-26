import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/goals_timeline_widget.dart';

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
    this.workoutExercise,
  });

  static const String title = 'Set your goals';

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final GlobalKey<GoalsTimelineWidgetState> goalsTimelineWidget =
      GlobalKey<GoalsTimelineWidgetState>();

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      title: GoalsPage.title,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoalsTimelineWidget(
                key: goalsTimelineWidget,
                exercise: widget.exercise,
                sets: widget.sets,
                existingGoals: widget.workoutExercise?.goals()!,
              ),
              FloatingCenteredButtonWidget(
                text:
                    "${widget.workoutExercise != null ? "Update" : "Add"} exercise",
                onPressed: () {
                  Goals? goals = goalsTimelineWidget.currentState?.goals;
                  WorkoutExercise workoutExercise = WorkoutExercise(
                    index: widget.workoutExercise != null
                        ? widget.workoutExercise!.index()
                        : widget.index,
                    exercise: widget.exercise,
                    sets: widget.sets,
                    notes: widget.notes,
                    goals: goals,
                  );
                  Navigator.pop(context, workoutExercise);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
