import 'package:overload/domain/workout/workout_exercise.dart';

class WorkoutExercises {
  final List<WorkoutExercise> _value;

  WorkoutExercises({
    required List<WorkoutExercise> value,
  }) : _value = List.unmodifiable(value);

  List<WorkoutExercise> value() {
    return _value;
  }

  int count() {
    return _value.length;
  }
}
