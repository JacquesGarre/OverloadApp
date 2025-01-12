import 'dart:async';
import 'package:overload/infrastructure/persistence/repositories/exercise_repository.dart';
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
        version: 1,
        onCreate: createDatabase,
      );
    }
    return await sqflite.openDatabase(path);
  }

  static FutureOr<void> createDatabase(sqflite.Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${ExerciseRepository.table} (
        id TEXT PRIMARY KEY,
        name TEXT NULL,
        units TEXT NOT NULL
      )
    ''');
  }
}
