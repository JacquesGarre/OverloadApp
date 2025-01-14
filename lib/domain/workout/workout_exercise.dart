import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/goal/goal.dart';
import 'package:overload/domain/workout/sets.dart';

class WorkoutExercise {
  
  final Exercise exercise;
  final Sets sets;
  final Sets? lastSessionSets;
  final Notes? notes;
  final Goal? goal;
  
  WorkoutExercise({
    required this.exercise,
    required this.sets,
    this.lastSessionSets,
    this.notes,
    this.goal,
  });

}
