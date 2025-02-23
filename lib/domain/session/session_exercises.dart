import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/domain/session/session_exercise/session_exercise_index.dart';
import 'package:overload/domain/user/weight.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercises.dart';

class SessionExercises {
  final List<SessionExercise> _value;

  SessionExercises({
    required List<SessionExercise> value,
  }) : _value = List.unmodifiable(value);

  List<SessionExercise> value() {
    return _value;
  }

  int count() {
    return _value.length;
  }

  static SessionExercises empty() {
    return SessionExercises(value: []);
  }

  SessionExercises add(SessionExercise exercise) {
    List<SessionExercise> newValue = List.from(_value);
    newValue.add(exercise);
    return SessionExercises(value: newValue);
  }

  SessionExercises remove(SessionExercise exercise) {
    List<SessionExercise> filteredList = _value.where((sessionExercise) {
      return !sessionExercise.index().equals(exercise.index());
    }).toList();
    List<SessionExercise> newValue = [];
    for (int i = 0; i < filteredList.length; i++) {
      SessionExercise sessionExercise = filteredList[i];
      newValue.add(
        SessionExercise(
          index: SessionExerciseIndex(value: i + 1),
          workoutExercise: sessionExercise.workoutExercise(),
          sets: sessionExercise.sets(),
          notes: sessionExercise.notes(),
        ),
      );
    }
    return SessionExercises(value: newValue);
  }

  SessionExercises update(SessionExercise exercise) {
    List<SessionExercise> newValue = List.from(_value);
    for (int i = 0; i < newValue.length; i++) {
      if (newValue[i].index().equals(exercise.index())) {
        newValue[i] = exercise;
        break;
      }
    }
    return SessionExercises(value: newValue);
  }

  SessionExercise? last() {
    if (_value.isEmpty) {
      return null;
    }
    return _value.last;
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> json = [];
    for (SessionExercise exercise in _value) {
      json.add(exercise.toJson());
    }
    return json;
  }

  static SessionExercises fromJson(List<Map<String, dynamic>> jsons) {
    List<SessionExercise> value = [];
    for (Map<String, dynamic> json in jsons) {
      value.add(SessionExercise.fromJson(json));
    }
    return SessionExercises(value: value);
  }

  static SessionExercises fromWorkoutExercises(
      WorkoutExercises workoutExercises) {
    List<SessionExercise> value = [];
    for (WorkoutExercise workoutExercise in workoutExercises.value()) {
      value.add(SessionExercise.fromWorkoutExercise(workoutExercise));
    }
    return SessionExercises(value: value);
  }

  SessionExercises withAtLeastOneSetDone() {
    List<SessionExercise> value = [];
    for (SessionExercise exercise in _value) {
      if (exercise.hasOneSetDone()) {
        value.add(exercise);
      }
    }
    return SessionExercises(value: value);
  }

  int finishedSetsCount() {
    int count = 0;
    for (SessionExercise exercise in _value) {
      count += exercise.finishedSetsCount();
    }
    return count;
  }

  num finishedVolume(Weight userWeight) {
    num volume = 0;
    for (SessionExercise exercise in _value) {
      volume += exercise.finishedVolume(userWeight);
    }
    return volume;
  }

  num finishedRepsCount() {
    num count = 0;
    for (SessionExercise exercise in _value) {
      count += exercise.finishedRepsCount();
    }
    return count;
  }

  SessionExercise? findSessionExercise(WorkoutExercise workoutExercise) {
    for (SessionExercise exercise in _value) {
      if (exercise.workoutExercise().id().equals(workoutExercise.id())) {
        return exercise;
      }
    }
    return null;
  }
}
