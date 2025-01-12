import 'dart:convert';

import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';

class ExerciseModel {
  final String id;
  final String name;
  final List<String> units;

  ExerciseModel._({required this.id, required this.name, required this.units});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'units': jsonEncode(units),
    };
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel._(
      id: map['id'] as String,
      name: map['name'] as String,
      units: List<String>.from(jsonDecode(map['units'] as String)),
    );
  }

  factory ExerciseModel.fromExercise(Exercise exercise) {
    return ExerciseModel._(
      id: exercise.id.toString(),
      name: exercise.name.value,
      units: exercise.units.toStringList(),
    );
  }

  Exercise toExercise() {
    Id exerciseId = Id.fromString(id);
    Name exerciseName = Name.fromString(name);
    Units exerciseUnits = Units.fromStringList(units);
    return Exercise(
      id: exerciseId,
      name: exerciseName,
      units: exerciseUnits,
    );
  }
}
