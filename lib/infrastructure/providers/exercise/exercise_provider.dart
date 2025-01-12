import 'package:flutter/material.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command_handler.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/units.dart';

class ExerciseProvider with ChangeNotifier {
  final AddExerciseCommandHandler addExerciseCommandHandler;

  ExerciseProvider({required this.addExerciseCommandHandler});

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

}
