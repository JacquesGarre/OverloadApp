import 'package:flutter/material.dart';
import 'package:overload/application/workout/add_workout_command/add_workout_command.dart';
import 'package:overload/application/workout/add_workout_command/add_workout_command_handler.dart';
import 'package:overload/application/workout/delete_workout_command/delete_workout_command.dart';
import 'package:overload/application/workout/delete_workout_command/delete_workout_command_handler.dart';
import 'package:overload/application/workout/generate_workouts_command/generate_workouts_command.dart';
import 'package:overload/application/workout/generate_workouts_command/generate_workouts_command_handler.dart';
import 'package:overload/application/workout/get_workouts_query/get_workouts_query.dart';
import 'package:overload/application/workout/get_workouts_query/get_workouts_query_handler.dart';
import 'package:overload/application/workout/update_workout_command/update_workout_command.dart';
import 'package:overload/application/workout/update_workout_command/update_workout_command_handler.dart';
import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercises.dart';

class WorkoutProvider with ChangeNotifier {
  final AddWorkoutCommandHandler addWorkoutCommandHandler;
  final GetWorkoutsQueryHandler getWorkoutsQueryHandler;
  final DeleteWorkoutCommandHandler deleteWorkoutCommandHandler;
  final UpdateWorkoutCommandHandler updateWorkoutCommandHandler;
  final GenerateWorkoutsCommandHandler generateWorkoutsCommandHandler;

  WorkoutProvider({
    required this.addWorkoutCommandHandler,
    required this.getWorkoutsQueryHandler,
    required this.deleteWorkoutCommandHandler,
    required this.updateWorkoutCommandHandler,
    required this.generateWorkoutsCommandHandler,
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

  Future<void> deleteWorkout(Workout workout) async {
    try {
      DeleteWorkoutCommand command = DeleteWorkoutCommand(
        id: workout.id().toString(),
      );
      await deleteWorkoutCommandHandler.invoke(command);
      await loadWorkouts();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> generateWorkouts() async {
    try {
      GenerateWorkoutsCommand command = GenerateWorkoutsCommand();
      await generateWorkoutsCommandHandler.invoke(command);
      await loadWorkouts();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateWorkout(
    Id id,
    String name,
    String? notes,
    WorkoutExercises workoutExercises,
  ) async {
    try {
      UpdateWorkoutCommand command = UpdateWorkoutCommand(
        id: id.toString(),
        name: name,
        notes: notes,
        workoutExercises: workoutExercises,
      );
      await updateWorkoutCommandHandler.invoke(command);
      await loadWorkouts();
    } catch (e) {
      rethrow;
    }
  }
}
