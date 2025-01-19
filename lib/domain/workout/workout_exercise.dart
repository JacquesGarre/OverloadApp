import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/goal.dart';
import 'package:overload/domain/workout/sets.dart';

class WorkoutExercise {
  final Exercise _exercise;
  final Sets _sets;
  final Notes? _notes;
  final Goals? _goals;

  WorkoutExercise({
    required Exercise exercise,
    required Sets sets,
    Notes? notes,
    Goals? goals,
  })  : _exercise = exercise,
        _sets = sets,
        _notes = notes,
        _goals = goals;

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
}
