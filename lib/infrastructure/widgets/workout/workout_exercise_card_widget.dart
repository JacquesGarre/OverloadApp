import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/widgets/sets/sets_table_widget.dart';

class WorkoutExerciseCardWidget extends StatelessWidget {
  final WorkoutExercise workoutExercise;
  final bool checkable;
  final bool setsNumberSelector;
  final bool readonly;
  final void Function(WorkoutExercise workoutExercise) onWorkoutExerciseRemoved;

  const WorkoutExerciseCardWidget(
      {super.key,
      required this.workoutExercise,
      required this.checkable,
      required this.setsNumberSelector,
      required this.readonly,
      required this.onWorkoutExerciseRemoved});

  _removeWorkoutExercise() {
    onWorkoutExerciseRemoved(workoutExercise);
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
                          workoutExercise.exercise().name().value(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      if (workoutExercise.goals() != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            6.0,
                            0.0,
                            0.0,
                            0.0,
                          ),
                          child: Text(
                            '${workoutExercise.goals()!.count()} objective${workoutExercise.goals()!.count() > 1 ? 's' : ''} left',
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
                      onPressed: () {},
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
              key: ValueKey(workoutExercise.id().value()),
              exercise: workoutExercise.exercise(),
              sets: workoutExercise.goals() != null &&
                      workoutExercise.goals()!.count() > 0
                  ? workoutExercise.goals()!.value().first.sets()
                  : workoutExercise.sets(),
              checkable: checkable,
              setsNumberSelector: setsNumberSelector,
              readonly: readonly,
              onSetsUpdated: (Sets sets) {
                // TODO
              },
            )
          ],
        ),
      ),
    );
  }
}
