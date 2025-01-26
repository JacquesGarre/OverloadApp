import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/workout_exercise/id.dart' as workout_exercise;
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';

abstract class WorkoutExerciseRepositoryInterface {
  Future<void> add(WorkoutExercise exercise);
  Future<void> update(WorkoutExercise exercise);
  Future<void> delete(WorkoutExercise exercise);
  Future<WorkoutExercise?> ofId(workout_exercise.Id id);
  Future<List<WorkoutExercise>> findByWorkoutId(Id workoutId);
}
