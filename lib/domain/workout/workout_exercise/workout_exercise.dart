import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/workout_exercise/id.dart';
import 'package:overload/domain/workout/id.dart' as workout;
import 'package:overload/domain/workout/workout_exercise/sets_count.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';

class WorkoutExercise {
  final Id _id;
  final workout.Id _workoutId;
  final WorkoutExerciseIndex _index;
  final Exercise _exercise;
  final SetsCount _setsCount;
  final Notes? _notes;
  final Goals? _goals;

  WorkoutExercise({
    required Id id,
    required workout.Id workoutId,
    required WorkoutExerciseIndex index,
    required Exercise exercise,
    required SetsCount setsCount,
    Notes? notes,
    Goals? goals,
  })  : _id = id,
        _workoutId = workoutId,
        _index = index,
        _exercise = exercise,
        _setsCount = setsCount,
        _notes = notes,
        _goals = goals;

  Id id() {
    return _id;
  }

  workout.Id workoutId() {
    return _workoutId;
  }

  WorkoutExerciseIndex index() {
    return _index;
  }

  Exercise exercise() {
    return _exercise;
  }

  SetsCount setsCount() {
    return _setsCount;
  }

  Notes? notes() {
    return _notes;
  }

  Goals? goals() {
    return _goals;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id.toString(),
      "workout_id": _workoutId.value().toString(),
      "index": _index.value().toString(),
      "exercise": _exercise.toJson(),
      "sets_count": _setsCount.value(),
      "notes": _notes?.value(),
      "goals": _goals?.toJson()
    };
  }

  static WorkoutExercise fromJson(Map<String, dynamic> json) {
    workout.Id workoutId = workout.Id.fromString(json["workout_id"]);
    Id id = Id.fromString(json["id"] as String);
    WorkoutExerciseIndex index =
        WorkoutExerciseIndex(value: int.parse(json["index"]));
    Exercise exercise = Exercise.fromJson(json["exercise"]);
    SetsCount setsCount = SetsCount(value: json["sets_count"]);
    Notes? notes;
    if (json["notes"] != null) {
      notes = Notes(value: json["notes"]);
    }
    Goals? goals;
    if (json["goals"] != null) {
      goals = Goals.fromJson(
        (json["goals"] as List).map((item) => item as Map<String, dynamic>).toList(),
      );
    }
    return WorkoutExercise(
      workoutId: workoutId,
      id: id,
      index: index,
      exercise: exercise,
      setsCount: setsCount,
      notes: notes,
      goals: goals,
    );
  }
}
