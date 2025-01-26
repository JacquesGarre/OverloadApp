import 'package:flutter/material.dart';
import 'package:overload/application/workout/add_workout_command/add_workout_command.dart';
import 'package:overload/application/workout/add_workout_command/add_workout_command_handler.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercises.dart';

class WorkoutProvider with ChangeNotifier {
  final AddWorkoutCommandHandler addWorkoutCommandHandler;

  WorkoutProvider({
    required this.addWorkoutCommandHandler,
  });

  List<Workout> _workouts = [];
  List<Workout> get workouts => _workouts;

  Future<void> loadWorkouts() async {}

  Future<void> addWorkout(
      String name, String? notes, WorkoutExercises workoutExercises) async {
    try {
      AddWorkoutCommand command = AddWorkoutCommand(
        name: name,
        workoutExercises: workoutExercises,
        notes: notes,
      );
      await addWorkoutCommandHandler.invoke(command);
      await loadWorkouts();
    } catch (e) {
      rethrow;
    }
  }
}
