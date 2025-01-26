import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/name.dart';
import 'package:overload/domain/workout/workout_repository_interface.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:sqflite/sqflite.dart';

class WorkoutRepository implements WorkoutRepositoryInterface {
  final Database db;

  static const String table = 'workouts';

  WorkoutRepository({required this.db});

  @override
  Future<void> add(Workout workout) async {
    await db.insert(table, workout.toJson());
  }

  @override
  Future<void> delete(Workout workout) async {
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [workout.id().toString()],
    );
  }

  @override
  Future<List<Workout>> findAll() async {
    List<Workout> workouts = [];
    List<Map<String, dynamic>> workoutsJsons = await db.query(table);
    for (Map<String, dynamic> workoutJson in workoutsJsons) {
      workouts.add(Workout.fromJson(workoutJson));
    }
    return workouts;
  }

  @override
  Future<void> update(Workout workout) async {
    await db.update(
      table,
      workout.toJson(),
      where: 'id = ?',
      whereArgs: [workout.id().toString()],
    );
  }

  @override
  Future<Workout?> ofId(Id id) async {
    List<Map<String, Object?>> workoutsJsons = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );
    if (workoutsJsons.isEmpty) {
      return null;
    }
    List<Workout> workouts = [];
    for (Map<String, Object?> workoutJson in workoutsJsons) {
      workouts.add(Workout.fromJson(workoutJson));
    }
    return workouts.first;
  }

  @override
  Future<Workout?> ofName(Name name) async {
    List<Map<String, Object?>> workoutsJsons = await db.query(
      table,
      where: 'name = ?',
      whereArgs: [name.toString()],
    );
    if (workoutsJsons.isEmpty) {
      return null;
    }
    List<Workout> workouts = [];
    for (Map<String, Object?> workoutJson in workoutsJsons) {
      workouts.add(Workout.fromJson(workoutJson));
    }
    return workouts.first;
  }
}
