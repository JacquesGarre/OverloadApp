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
      newValue.add(
        WorkoutExercise(
          id: workoutExercise.id(),
          workoutId: workoutExercise.workoutId(),
          index: WorkoutExerciseIndex(value: i + 1),
          exercise: workoutExercise.exercise(),
          setsCount: workoutExercise.setsCount(),
          notes: workoutExercise.notes(),
          goals: workoutExercise.goals(),
        ),
      );
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

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> json = [];
    for(WorkoutExercise exercise in _value) {
      json.add(exercise.toJson());
    }
    return json;
  }

  static WorkoutExercises fromJson(List<Map<String, dynamic>> jsons) {
    List<WorkoutExercise> value = [];
    for(Map<String, dynamic> json in jsons) {
      value.add(WorkoutExercise.fromJson(json));
    }
    return WorkoutExercises(value: value);
  }

}
