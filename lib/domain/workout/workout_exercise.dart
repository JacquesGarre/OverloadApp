import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/objective/objective.dart';
import 'package:overload/domain/workout/sets.dart';

class WorkoutExercise {

  final Exercise exercise;
  final Notes notes;
  final Sets sets;
  final Objective? objective;
  
  WorkoutExercise({
    required this.exercise,
    required this.notes,
    required this.sets,
    this.objective,
  });

}
