import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise/id.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';

class WorkoutExercise {

  final Id _id;
  final WorkoutExerciseIndex _index;
  final Exercise _exercise;
  final Sets _sets;
  final Notes? _notes;
  final Goals? _goals;

  WorkoutExercise({
    required WorkoutExerciseIndex index,
    required Exercise exercise,
    required Sets sets,
    Notes? notes,
    Goals? goals,
  })  : _id = Id.create(),
        _index = index,
        _exercise = exercise,
        _sets = sets,
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

  Sets sets() {
    return _sets;
  }

  Notes? notes() {
    return _notes;
  }
  
  Goals? goals() {
    return _goals;
  }

  @override  
  String toString() { // TODO: Remove, just for logs
    return "[Workout exercice] Index: $_index \n Exercise : $_exercise \n Sets $_sets \n Notes \n $_notes Goals \n $_goals";
  }
}
