import 'package:faker/faker.dart';
import 'package:overload/domain/workout/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercises.dart';

import 'workout_exercise_stub.dart';

class WorkoutExercisesStub {
  static WorkoutExercises random() {
    List<WorkoutExercise> value = [];
    for (var i = 0; i <= faker.randomGenerator.integer(5, min: 1); i++) {
      value.add(WorkoutExerciseStub.random());
    }
    return WorkoutExercises(value: value);
  }
}
