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

  static WorkoutExercises empty() {
    return WorkoutExercises(value: []);
  }

  WorkoutExercises add(WorkoutExercise exercise) {
    List<WorkoutExercise> newValue = List.from(_value);
    newValue.add(exercise);
    return WorkoutExercises(value: newValue);
  }
}
