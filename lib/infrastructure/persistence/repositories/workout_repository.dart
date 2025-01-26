import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/interface/workout_exercise_repository_interface.dart';
import 'package:overload/domain/workout/name.dart';
import 'package:overload/domain/workout/interface/workout_repository_interface.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/infrastructure/persistence/repositories/workout_exercise_repository.dart';
import 'package:sqflite/sqflite.dart';

class WorkoutRepository implements WorkoutRepositoryInterface {

  final Database db;
  final WorkoutExerciseRepositoryInterface workoutExercisesRepository;

  static const String table = 'workouts';

  WorkoutRepository({required this.db}) : workoutExercisesRepository = WorkoutExerciseRepository(db: db);

  @override
  Future<void> add(Workout workout) async {
    // WorkoutModel model = WorkoutModel.fromWorkout(workout);
    // await db.insert(table, model.toMap());
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
    // List<Map<String, dynamic>> workoutsMaps = await db.query(table);
    // for(Map<String, dynamic> workoutMap in workoutsMaps) {
    //   WorkoutModel model = WorkoutModel.fromMap(workoutMap);
    //   workouts.add(model.toWorkout());
    // }
    return workouts;
  }

  @override
  Future<void> update(Workout workout) async {
    // WorkoutModel model = WorkoutModel.fromWorkout(workout);
    // await db.update(
    //   table,
    //   model.toMap(),
    //   where: 'id = ?',
    //   whereArgs: [workout.id().toString()],
    // );
  }

  @override
  Future<Workout?> ofId(Id id) async {
    List<Map<String, Object?>> workoutsMaps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );    
    if(workoutsMaps.isEmpty){
      return null;
    }
    List<Workout> workouts = [];
    for(Map<String, Object?> workoutMap in workoutsMaps) {
      // WorkoutModel model = WorkoutModel.fromMap(workoutMap);
      // workouts.add(model.toWorkout());
    }
    return workouts.first;
  }

  @override
  Future<Workout?> ofName(Name name) async {
    List<Map<String, Object?>> workoutsMaps = await db.query(
      table,
      where: 'name = ?',
      whereArgs: [name.value()],
    );    
    if(workoutsMaps.isEmpty){
      return null;
    }
    List<Workout> workouts = [];
    for(Map<String, Object?> workoutMap in workoutsMaps) {
      // WorkoutModel model = WorkoutModel.fromMap(workoutMap);
      // workouts.add(model.toWorkout());
    }
    return workouts.first;
  }
}