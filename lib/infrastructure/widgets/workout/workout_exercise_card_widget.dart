import 'package:flutter/material.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/widgets/sets/sets_table_widget.dart';

class WorkoutExerciseCardWidget extends StatelessWidget {

  final WorkoutExercise workoutExercise;
  final bool checkable;

  const WorkoutExerciseCardWidget({super.key, required this.workoutExercise, required this.checkable});

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
                      Text(
                        workoutExercise.exercise().name().value(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5.0),
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
                      onPressed: () async {},
                    ),
                  ],
                ),
              ],
            ),
            SetsTableWidget(
              exercise: workoutExercise.exercise(),
              sets: workoutExercise.sets(),
              checkable: checkable,
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
