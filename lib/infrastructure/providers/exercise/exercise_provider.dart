import 'package:flutter/material.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command_handler.dart';
import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command.dart';
import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command_handler.dart';
import 'package:overload/application/exercise/get_exercises_query/get_exercises_query.dart';
import 'package:overload/application/exercise/get_exercises_query/get_exercises_query_handler.dart';
import 'package:overload/application/exercise/update_exercise_command/update_exercise_command.dart';
import 'package:overload/application/exercise/update_exercise_command/update_exercise_command_handler.dart';
import 'package:overload/domain/exercise/exercise.dart';

class ExerciseProvider with ChangeNotifier {
  
  final GetExercisesQueryHandler getExercisesQueryHandler;
  final AddExerciseCommandHandler addExerciseCommandHandler;
  final DeleteExerciseCommandHandler deleteExerciseCommandHandler;
  final UpdateExerciseCommandHandler updateExerciseCommandHandler;

  ExerciseProvider({
    required this.getExercisesQueryHandler,
    required this.addExerciseCommandHandler,
    required this.deleteExerciseCommandHandler,
    required this.updateExerciseCommandHandler,
  });

  List<Exercise> _exercises = [];
  List<Exercise> get exercises => _exercises;

  Future<void> loadExercises() async {
    GetExercisesQuery query = GetExercisesQuery();
    _exercises = await getExercisesQueryHandler.invoke(query);
    notifyListeners();
  }

  Future<void> addExercise(Map<String, dynamic> formData) async {
    AddExerciseCommand command = AddExerciseCommand(
      name: formData["name"],
      units: formData["units"],
    );
    await addExerciseCommandHandler.invoke(command);
    loadExercises();
  }

  Future<void> deleteExercice(Exercise exercise) async {
    DeleteExerciseCommand command = DeleteExerciseCommand(
      id: exercise.id.toString(),
    );
    await deleteExerciseCommandHandler.invoke(command);
    loadExercises();
  }

  Future<void> updateExercise(Exercise exercise, Map<String, dynamic> formData) async {
    UpdateExerciseCommand command = UpdateExerciseCommand(
      id: exercise.id.toString(),
      name: formData["name"],
      units: formData["units"],
    );
    await updateExerciseCommandHandler.invoke(command);
    loadExercises();
  }
}
