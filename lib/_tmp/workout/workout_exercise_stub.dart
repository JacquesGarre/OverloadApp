import 'package:overload/_tmp/exercise/exercise_stub.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';

import 'notes_stub.dart';
import 'sets_stub.dart';

class WorkoutExerciseStub {
  static WorkoutExercise random() {
    Exercise exercise = ExerciseStub.random();
    Sets sets = SetsStub.random();
    return WorkoutExercise(
      index: WorkoutExerciseIndex(value: 1),
      exercise: exercise,
      sets: sets,
      notes: NotesStub.random(),
    );
  }
}
