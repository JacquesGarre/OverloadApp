import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/name.dart';
import 'package:overload/domain/workout/workout_exercises.dart';

class Workout {

  final Id id;
  final Name name;
  final WorkoutExercises exercises;

  Workout({
    required this.id,
    required this.name,
    required this.exercises,
  });
  
}
