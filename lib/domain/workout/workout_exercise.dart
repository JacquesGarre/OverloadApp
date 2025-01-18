import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/goal.dart';
import 'package:overload/domain/workout/sets.dart';

class WorkoutExercise {
  
  final Exercise exercise;
  final Sets sets;
  final Notes? notes;
  final Goal? currentGoal;
  final Goals? goals;
  
  WorkoutExercise({
    required this.exercise,
    required this.sets,
    this.notes,
    this.currentGoal,
    this.goals
  });

}
