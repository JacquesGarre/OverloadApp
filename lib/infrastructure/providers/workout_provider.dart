import 'package:flutter/material.dart';
import 'package:overload/application/workout/add_workout_command/add_workout_command.dart';
import 'package:overload/application/workout/add_workout_command/add_workout_command_handler.dart';
import 'package:overload/application/workout/get_workouts_query/get_workouts_query.dart';
import 'package:overload/application/workout/get_workouts_query/get_workouts_query_handler.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercises.dart';

class WorkoutProvider with ChangeNotifier {
  final AddWorkoutCommandHandler addWorkoutCommandHandler;
  final GetWorkoutsQueryHandler getWorkoutsQueryHandler;

  WorkoutProvider({
    required this.addWorkoutCommandHandler,
    required this.getWorkoutsQueryHandler,
  });

  List<Workout> _workouts = [];
  List<Workout> get workouts => _workouts;

  Future<void> loadWorkouts() async {
    GetWorkoutsQuery query = GetWorkoutsQuery();
    _workouts = await getWorkoutsQueryHandler.invoke(query);
    notifyListeners();
  }

  Future<void> addWorkout(
    String name,
    String? notes,
    WorkoutExercises workoutExercises,
  ) async {
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
