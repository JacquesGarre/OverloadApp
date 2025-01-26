import 'package:overload/domain/workout/id.dart' as workout;
import 'package:overload/domain/workout/workout_exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/workout/interface/workout_exercise_repository_interface.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:sqflite/sqflite.dart';

class WorkoutExerciseRepository implements WorkoutExerciseRepositoryInterface {

  final Database db;

  static const String table = 'workout_exercises';

  WorkoutExerciseRepository({required this.db});

  @override
  Future<void> add(WorkoutExercise exercise) async {
    // WorkoutExerciseModel model = WorkoutExerciseModel.fromWorkoutExercise(exercise);
    // await db.insert(table, model.toMap());
  }

  @override
  Future<void> delete(WorkoutExercise exercise) async {
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [exercise.id().toString()],
    );
  }

  @override
  Future<List<WorkoutExercise>> findByWorkoutId(workout.Id workoutId) async {
    List<WorkoutExercise> exercises = [];
    List<Map<String, dynamic>> exercisesMaps = await db.query(table);
    for(Map<String, dynamic> exerciseMap in exercisesMaps) {
      // WorkoutExerciseModel model = WorkoutExerciseModel.fromMap(exerciseMap);
      // exercises.add(model.toWorkoutExercise());
    }
    return exercises;
  }

  @override
  Future<void> update(WorkoutExercise exercise) async {
    // WorkoutExerciseModel model = WorkoutExerciseModel.fromWorkoutExercise(exercise);
    // await db.update(
    //   table,
    //   model.toMap(),
    //   where: 'id = ?',
    //   whereArgs: [exercise.id().toString()],
    // );
  }

  @override
  Future<WorkoutExercise?> ofId(Id id) async {
    List<Map<String, Object?>> exercisesMaps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );    
    if(exercisesMaps.isEmpty){
      return null;
    }
    List<WorkoutExercise> exercises = [];
    for(Map<String, Object?> exerciseMap in exercisesMaps) {
      // WorkoutExerciseModel model = WorkoutExerciseModel.fromMap(exerciseMap);
      // exercises.add(model.toWorkoutExercise());
    }
    return exercises.first;
  }

  @override
  Future<WorkoutExercise?> ofName(Name name) async {
    List<Map<String, Object?>> exercisesMaps = await db.query(
      table,
      where: 'name = ?',
      whereArgs: [name.value()],
    );    
    if(exercisesMaps.isEmpty){
      return null;
    }
    List<WorkoutExercise> exercises = [];
    for(Map<String, Object?> exerciseMap in exercisesMaps) {
      // WorkoutExerciseModel model = WorkoutExerciseModel.fromMap(exerciseMap);
      // exercises.add(model.toWorkoutExercise());
    }
    return exercises.first;
  }
}