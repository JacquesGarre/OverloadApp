import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/shared/notes.dart';
import 'package:overload/domain/workout/id.dart' as workout;
import 'package:overload/domain/workout/workout_exercise/id.dart';
import 'package:overload/domain/workout/workout_exercise/sets_count.dart';
import 'package:overload/domain/workout/workout_exercise/timer.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/goals_timeline_widget.dart';

class GoalsPage extends StatefulWidget {
  final workout.Id workoutId;
  final WorkoutExerciseIndex index;
  final Exercise exercise;
  final SetsCount setsCount;
  final Notes? notes;
  final WorkoutExercise? workoutExercise;
  final Timer? timer;

  const GoalsPage({
    super.key,
    required this.workoutId,
    required this.index,
    required this.exercise,
    required this.setsCount,
    this.notes,
    this.workoutExercise,
    this.timer,
  });

  static const String title = 'Set your goals';

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  late WorkoutExercise workoutExercise;
  final GlobalKey<GoalsTimelineWidgetState> goalsTimelineWidget =
      GlobalKey<GoalsTimelineWidgetState>();

  @override
  void initState() {
    super.initState();
    workoutExercise = widget.workoutExercise ??
        WorkoutExercise(
          workoutId: widget.workoutId,
          id: widget.workoutExercise != null
              ? widget.workoutExercise!.id()
              : Id.create(),
          index: widget.workoutExercise != null
              ? widget.workoutExercise!.index()
              : widget.index,
          exercise: widget.exercise,
          setsCount: widget.setsCount,
          notes: widget.notes,
          goals: widget.workoutExercise != null
              ? widget.workoutExercise!.goals()
              : Goals.empty(),
          timer: widget.timer,
        );
  }

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
                workoutExercise: workoutExercise,
                setsCount: widget.setsCount,
                goals: workoutExercise.goals(),
              ),
              FloatingCenteredButtonWidget(
                text:
                    "${widget.workoutExercise != null ? "Update" : "Add"} exercise",
                onPressed: () {
                  Goals? goals = goalsTimelineWidget.currentState?.goals;
                  WorkoutExercise workoutExercise = WorkoutExercise(
                    workoutId: widget.workoutId,
                    id: widget.workoutExercise != null
                        ? widget.workoutExercise!.id()
                        : Id.create(),
                    index: widget.workoutExercise != null
                        ? widget.workoutExercise!.index()
                        : widget.index,
                    exercise: widget.exercise,
                    setsCount: widget.setsCount,
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
