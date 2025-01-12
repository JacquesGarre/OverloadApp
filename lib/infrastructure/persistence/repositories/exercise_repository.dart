import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/exercise_repository_interface.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/infrastructure/persistence/models/exercise_model.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseRepository implements ExerciseRepositoryInterface {

  final Database db;

  static const String table = 'exercises';

  ExerciseRepository({required this.db});

  @override
  Future<void> add(Exercise exercise) async {
    ExerciseModel model = ExerciseModel.fromExercise(exercise);
    await db.insert(table, model.toMap());
  }

  @override
  Future<void> delete(Exercise exercise) async {
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [exercise.id.toString()],
    );
  }

  @override
  Future<List<Exercise>> findAll() async {
    List<Exercise> exercises = [];
    List<Map<String, dynamic>> exercisesMaps = await db.query(table);
    for(Map<String, dynamic> exerciseMap in exercisesMaps) {
      ExerciseModel model = ExerciseModel.fromMap(exerciseMap);
      exercises.add(model.toExercise());
    }
    return exercises;
  }

  @override
  Future<void> update(Exercise exercise) async {
    ExerciseModel model = ExerciseModel.fromExercise(exercise);
    await db.update(
      table,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [exercise.id.toString()],
    );
  }

  @override
  Future<Exercise?> ofId(Id id) async {
    List<Map<String, Object?>> exercisesMaps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );    
    if(exercisesMaps.isEmpty){
      return null;
    }
    List<Exercise> exercises = [];
    for(Map<String, Object?> exerciseMap in exercisesMaps) {
      ExerciseModel model = ExerciseModel.fromMap(exerciseMap);
      exercises.add(model.toExercise());
    }
    return exercises.first;
  }

  @override
  Future<Exercise?> ofName(Name name) async {
    List<Map<String, Object?>> exercisesMaps = await db.query(
      table,
      where: 'name = ?',
      whereArgs: [name.value],
    );    
    if(exercisesMaps.isEmpty){
      return null;
    }
    List<Exercise> exercises = [];
    for(Map<String, Object?> exerciseMap in exercisesMaps) {
      ExerciseModel model = ExerciseModel.fromMap(exerciseMap);
      exercises.add(model.toExercise());
    }
    return exercises.first;
  }
}