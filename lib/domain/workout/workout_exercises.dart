import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';

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

  WorkoutExercises remove(WorkoutExercise exercise) {
    List<WorkoutExercise> filteredList = _value.where((workoutExercise) {
      return !workoutExercise.index().equals(exercise.index());
    }).toList();
    List<WorkoutExercise> newValue = [];
    for (int i = 0; i < filteredList.length; i++) {
      WorkoutExercise workoutExercise = filteredList[i];
      newValue.add(WorkoutExercise(
        index: WorkoutExerciseIndex(value: i + 1),
        exercise: workoutExercise.exercise(),
        sets: workoutExercise.sets(),
      ));
    }
    return WorkoutExercises(value: newValue);
  }

  WorkoutExercises update(WorkoutExercise exercise) {
    List<WorkoutExercise> newValue = List.from(_value);
    for (int i = 0; i < newValue.length; i++) {
      if (newValue[i].index().equals(exercise.index())) {
        newValue[i] = exercise;
        break;
      }
    }
    return WorkoutExercises(value: newValue);
  }

  WorkoutExercise? last() {
    if (_value.isEmpty) {
      return null;
    }
    return _value.last;
  }

  @override
  String toString() { // TODO: Remove, just for logs
    String string = "Workout exercises \n";
    for(WorkoutExercise workoutExercise in _value) {
      string = "$string $workoutExercise";
    }
    return string;
  }
}
