import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/infrastructure/pages/workout/edit_workout_exercise_page.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/widgets/sets/sets_table_widget.dart';

class WorkoutExerciseCardWidget extends StatefulWidget {
  final WorkoutExercise workoutExercise;
  final bool checkable;
  final bool setsNumberSelector;
  final bool readonly;
  final void Function(WorkoutExercise workoutExercise) onWorkoutExerciseRemoved;

  const WorkoutExerciseCardWidget({
    super.key,
    required this.workoutExercise,
    required this.checkable,
    required this.setsNumberSelector,
    required this.readonly,
    required this.onWorkoutExerciseRemoved,
  });

  @override
  State<WorkoutExerciseCardWidget> createState() =>
      _WorkoutExerciseCardWidgetState();
}

class _WorkoutExerciseCardWidgetState extends State<WorkoutExerciseCardWidget> {
  void _removeWorkoutExercise() {
    widget.onWorkoutExerciseRemoved(widget.workoutExercise);
  }

  void _navigateToEditExercisePage() async {
    WorkoutExercise? newExercise = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditWorkoutExercisePage(
          workoutExercise: widget.workoutExercise,
        ),
      ),
    );
    if (newExercise != null) {
      setState(() {
        // If you need to update the workoutExercise locally after editing
        // Note: Only do this if it's safe to mutate locally
        Logger().i('Updated workout exercise: $newExercise');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: AppColorScheme.lightBackground,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                        child: Text(
                          widget.workoutExercise.exercise().name().value(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      if (widget.workoutExercise.goals() != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            6.0,
                            0.0,
                            0.0,
                            0.0,
                          ),
                          child: Text(
                            '${widget.workoutExercise.goals()!.count()} objective${widget.workoutExercise.goals()!.count() > 1 ? 's' : ''} left',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColorScheme.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: AppColorScheme.primary,
                      onPressed: _navigateToEditExercisePage,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: AppColorScheme.primary,
                      onPressed: _removeWorkoutExercise,
                    ),
                  ],
                ),
              ],
            ),
            SetsTableWidget(
              key: ValueKey(widget.workoutExercise.id().value()),
              exercise: widget.workoutExercise.exercise(),
              sets: widget.workoutExercise.goals() != null &&
                      widget.workoutExercise.goals()!.count() > 0
                  ? widget.workoutExercise.goals()!.value().first.sets()
                  : widget.workoutExercise.sets(),
              checkable: widget.checkable,
              setsNumberSelector: widget.setsNumberSelector,
              readonly: widget.readonly,
              onSetsUpdated: (Sets sets) {
                Logger().i('Sets updated: $sets');
              },
            )
          ],
        ),
      ),
    );
  }
}
