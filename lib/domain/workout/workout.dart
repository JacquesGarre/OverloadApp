import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/name.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/workout_exercises.dart';

class Workout {
  final Id _id;
  final Name _name;
  final WorkoutExercises _exercises;
  final Notes? _notes;

  Workout({
    required Id id,
    required Name name,
    required WorkoutExercises exercises,
    Notes? notes,
  })  : _id = id,
        _name = name,
        _exercises = exercises,
        _notes = notes;

  Id id() {
    return _id;
  }

  Name name() {
    return _name;
  }

  WorkoutExercises exercises() {
    return _exercises;
  }

  Notes? notes() {
    return _notes;
  }

  int exercisesCount() {
    return _exercises.count();
  }
}
