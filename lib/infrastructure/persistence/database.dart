import 'dart:async';
import 'package:overload/infrastructure/persistence/repositories/exercise_repository.dart';
import 'package:overload/infrastructure/persistence/repositories/session_repository.dart';
import 'package:overload/infrastructure/persistence/repositories/user_repository.dart';
import 'package:overload/infrastructure/persistence/repositories/workout_repository.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

class Database {
  static Future<sqflite.Database> getDatabase() async {
    String databasesPath = await sqflite.getDatabasesPath();
    String path = join(databasesPath, "overload.db");
    bool exists = await sqflite.databaseExists(path);
    if (!exists) {
      return await sqflite.openDatabase(
        path,
        version: 6,
        onCreate: (db, version) async {
          await createDatabase(db);
        },
      );
    }
    return await sqflite.openDatabase(path);
  }

  static FutureOr<void> createDatabase(sqflite.Database db) async {
    await db.execute('''
      CREATE TABLE ${ExerciseRepository.table} (
        id TEXT PRIMARY KEY,
        name TEXT NULL,
        units TEXT NULL,
        is_body_weight_exercise TEXT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${WorkoutRepository.table} (
        id TEXT PRIMARY KEY,
        workout_exercises TEXT NULL,
        name TEXT NULL,
        notes TEXT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${SessionRepository.table} (
        id TEXT PRIMARY KEY,
        workout_id TEXT NULL,
        workout TEXT NULL,
        start_date TEXT NULL,
        end_date TEXT NULL,
        exercises TEXT NULL,
        notes TEXT NULL,
        session_number TEXT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${UserRepository.table} (
        id TEXT PRIMARY KEY,
        username TEXT NULL,
        age TEXT NULL,
        weight TEXT NULL,
        completed_profile TEXT NULL,
        gender TEXT NULL,
        training_types TEXT NULL,
        workout_duration_preference TEXT NULL,
        training_locations TEXT NULL,
        motivation_preferences TEXT NULL,
        fitness_level TEXT NULL,
        fitness_goals TEXT NULL,
        equipment TEXT NULL,
        workout_weekly_days TEXT NULL
      )
    ''');
  }
}
