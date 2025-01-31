import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_exercise/session_exercise_index.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';

class SessionExercise {
  final SessionExerciseIndex _index;
  final WorkoutExercise _workoutExercise;
  final Sets _sets;
  final Notes? _notes;

  SessionExercise({
    required index,
    required workoutExercise,
    required sets,
    notes,
  })  : _index = index,
        _workoutExercise = workoutExercise,
        _sets = sets,
        _notes = notes;

  SessionExerciseIndex index() {
    return _index;
  }

  WorkoutExercise workoutExercise() {
    return _workoutExercise;
  }

  Sets sets() {
    return _sets;
  }

  Notes? notes() {
    return _notes;
  }

  Map<String, dynamic> toJson() {
    return {
      "index": _index.value(),
      "workout_exercise": _workoutExercise.toJson(),
      "sets": _sets.toJson(),
      "notes": _notes?.value(),
    };
  }

  static SessionExercise fromJson(Map<String, dynamic> json) {
    SessionExerciseIndex index = SessionExerciseIndex(value: json["index"]);
    WorkoutExercise workoutExercise = WorkoutExercise.fromJson(
      json["workout_exercise"],
    );
    Sets sets = Sets.fromJson((json["sets"] as List)
        .map((item) => item as Map<String, dynamic>)
        .toList());
    Notes? notes = Notes.fromString(json["notes"]);
    return SessionExercise(
      index: index,
      workoutExercise: workoutExercise,
      sets: sets,
      notes: notes,
    );
  }

  static SessionExercise fromWorkoutExercise(WorkoutExercise workoutExercise) {
    SessionExerciseIndex index = SessionExerciseIndex.fromWorkoutExerciseIndex(
      workoutExercise.index(),
    );
    Sets sets = Sets.fromSetsCountAndExercise(
      workoutExercise.setsCount(),
      workoutExercise.exercise(),
    );
    return SessionExercise(
      index: index,
      workoutExercise: workoutExercise,
      sets: sets,
    );
  }

  SessionExercise updateSets(Sets sets) {
    return SessionExercise(
      index: index(),
      workoutExercise: workoutExercise(),
      sets: sets,
    );
  }
}
