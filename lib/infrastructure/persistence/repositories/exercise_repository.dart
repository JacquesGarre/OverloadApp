import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/exercise_repository_interface.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseRepository implements ExerciseRepositoryInterface {

  final Database db;

  static const String table = 'exercises';

  ExerciseRepository({required this.db});

  @override
  Future<void> add(Exercise exercise) async {
    await db.insert(table, exercise.toJson());
  }

  @override
  Future<void> delete(Exercise exercise) async {
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [exercise.id().toString()],
    );
  }

  @override
  Future<List<Exercise>> findAll() async {
    List<Exercise> exercises = [];
    List<Map<String, dynamic>> exercisesJsons = await db.query(table);
    for(Map<String, dynamic> exerciseJson in exercisesJsons) {
      exercises.add(Exercise.fromJson(exerciseJson));
    }
    return exercises;
  }

  @override
  Future<void> update(Exercise exercise) async {
    await db.update(
      table,
      exercise.toJson(),
      where: 'id = ?',
      whereArgs: [exercise.id().toString()],
    );
  }

  @override
  Future<Exercise?> ofId(Id id) async {
    List<Map<String, Object?>> exercisesJsons = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );    
    if(exercisesJsons.isEmpty){
      return null;
    }
    List<Exercise> exercises = [];
    for(Map<String, Object?> exerciseJson in exercisesJsons) {
      exercises.add(Exercise.fromJson(exerciseJson));
    }
    return exercises.first;
  }

  @override
  Future<Exercise?> ofName(Name name) async {
    List<Map<String, Object?>> exercisesJsons = await db.query(
      table,
      where: 'name = ?',
      whereArgs: [name.value()],
    );    
    if(exercisesJsons.isEmpty){
      return null;
    }
    List<Exercise> exercises = [];
    for(Map<String, Object?> exerciseJson in exercisesJsons) {
      exercises.add(Exercise.fromJson(exerciseJson));
    }
    return exercises.first;
  }
}