import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise/id.dart';
import 'package:overload/domain/workout/workout_exercise/sets_count.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';

class WorkoutExercise {

  final Id _id;
  final WorkoutExerciseIndex _index;
  final Exercise _exercise;
  final SetsCount _setsCount;
  final Notes? _notes;
  final Goals? _goals;

  WorkoutExercise({
    required WorkoutExerciseIndex index,
    required Exercise exercise,
    required SetsCount setsCount,
    Notes? notes,
    Goals? goals,
  })  : _id = Id.create(),
        _index = index,
        _exercise = exercise,
        _setsCount = setsCount,
        _notes = notes,
        _goals = goals;

  Id id() {
    return _id;
  }

  WorkoutExerciseIndex index() {
    return _index;
  }

  Exercise exercise() {
    return _exercise;
  }

  SetsCount setsCount() {
    return _setsCount;
  }

  Notes? notes() {
    return _notes;
  }
  
  Goals? goals() {
    return _goals;
  }
}
