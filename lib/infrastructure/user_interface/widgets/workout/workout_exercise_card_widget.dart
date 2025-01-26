import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/infrastructure/user_interface/pages/workout/edit_workout_exercise_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class WorkoutExerciseCardWidget extends StatefulWidget {
  final WorkoutExercise workoutExercise;
  final bool checkable;
  final bool setsNumberSelector;
  final bool readonly;
  final void Function(WorkoutExercise workoutExercise) onWorkoutExerciseRemoved;
  final void Function(WorkoutExercise workoutExercise) onWorkoutExerciseUpdated;

  const WorkoutExerciseCardWidget({
    super.key,
    required this.workoutExercise,
    required this.checkable,
    required this.setsNumberSelector,
    required this.readonly,
    required this.onWorkoutExerciseRemoved,
    required this.onWorkoutExerciseUpdated,
  });

  @override
  State<WorkoutExerciseCardWidget> createState() =>
      _WorkoutExerciseCardWidgetState();
}

class _WorkoutExerciseCardWidgetState extends State<WorkoutExerciseCardWidget> {
  late WorkoutExercise workoutExercise;

  @override
  void initState() {
    super.initState();
    setState(() {
      workoutExercise = widget.workoutExercise;
    });
  }

  void _removeWorkoutExercise() {
    widget.onWorkoutExerciseRemoved(widget.workoutExercise);
  }

  void _navigateToEditExercisePage() async {
    WorkoutExercise? updatedWorkoutExercise = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditWorkoutExercisePage(
          workoutExercise: widget.workoutExercise,
        ),
      ),
    );
    if (updatedWorkoutExercise != null) {
      setState(() {
        workoutExercise = updatedWorkoutExercise;
        widget.onWorkoutExerciseUpdated(updatedWorkoutExercise);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: AppColorScheme.lightBackground,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 5.0),
                            child: Text(
                              workoutExercise.exercise().name().value(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 6.0, 5.0),
                            child: Text(
                              "(${workoutExercise.setsCount().value()} set${workoutExercise.setsCount().value() > 1 ? 's' : ''})",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (workoutExercise.notes() != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            6.0,
                            0.0,
                            0.0,
                            10.0,
                          ),
                          child: Text(
                            'Notes: ${workoutExercise.notes()!.value()}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColorScheme.onLightBackground,
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
          ],
        ),
      ),
    );
  }
}
