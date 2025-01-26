import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/name.dart';
import 'package:overload/domain/workout/workout.dart';

abstract class WorkoutRepositoryInterface {
  Future<void> add(Workout workout);
  Future<void> update(Workout workout);
  Future<void> delete(Workout workout);
  Future<Workout?> ofId(Id id);
  Future<Workout?> ofName(Name name);
  Future<List<Workout>> findAll();
}
