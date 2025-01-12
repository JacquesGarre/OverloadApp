import 'package:flutter/material.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command_handler.dart';
import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command.dart';
import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command_handler.dart';
import 'package:overload/application/exercise/update_exercise_command/update_exercise_command.dart';
import 'package:overload/application/exercise/update_exercise_command/update_exercise_command_handler.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/units.dart';

class ExerciseProvider with ChangeNotifier {
  final AddExerciseCommandHandler addExerciseCommandHandler;
  final DeleteExerciseCommandHandler deleteExerciseCommandHandler;
  final UpdateExerciseCommandHandler updateExerciseCommandHandler;

  ExerciseProvider({
    required this.addExerciseCommandHandler,
    required this.deleteExerciseCommandHandler,
    required this.updateExerciseCommandHandler,
  });

  final List<Exercise> _exercises = [
    Exercise.create(
      Name.fromString("Chest press"),
      Units.fromUnitList([
        Unit.reps,
        Unit.kgs,
        Unit.restTime,
      ]),
    ),
    Exercise.create(
      Name.fromString("Shoulder press"),
      Units.fromUnitList([
        Unit.reps,
        Unit.kgs,
        Unit.restTime,
      ]),
    ),
  ];
  List<Exercise> get exercises => _exercises;

  void addExercise(Map<String, dynamic> formData) {
    AddExerciseCommand command = AddExerciseCommand(
      name: formData["name"],
      units: formData["units"],
    );
    Exercise exercise = addExerciseCommandHandler.invoke(command);
    _exercises.add(exercise);
    notifyListeners();
  }

  void deleteExercice(Exercise exercise) {
    DeleteExerciseCommand command = DeleteExerciseCommand(
      id: exercise.id.toString(),
    );
    deleteExerciseCommandHandler.invoke(command);
    _exercises.removeWhere((ex) => ex.id.equals(exercise.id));
    notifyListeners();
  }

  void updateExercise(Exercise exercise, Map<String, dynamic> formData) {
    UpdateExerciseCommand command = UpdateExerciseCommand(
      id: exercise.id.toString(),
      name: formData["name"],
      units: formData["units"],
    );
    Exercise updatedExercise = updateExerciseCommandHandler.invoke(command);
    int index = _exercises.indexWhere((ex) => ex.id.equals(updatedExercise.id));
    if (index != -1) {
      _exercises[index] = updatedExercise;
    }
    notifyListeners();
  }
}
