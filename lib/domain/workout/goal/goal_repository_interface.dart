

import 'package:overload/domain/workout/goal/goal.dart';
import 'package:overload/domain/workout/goal/id.dart';
import 'package:overload/domain/workout/workout_exercise/id.dart' as workout_exercise;

abstract class GoalRepositoryInterface {
  Future<void> add(Goal goal);
  Future<void> update(Goal goal);
  Future<void> delete(Goal goal);
  Future<Goal?> ofId(Id id);
  Future<List<Goal>> findByWorkoutExerciseId(workout_exercise.Id workoutExerciseId); 
}
