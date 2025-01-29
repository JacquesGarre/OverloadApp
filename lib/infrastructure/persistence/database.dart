import 'dart:async';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/workout/id.dart' as workout_id;
import 'package:overload/domain/workout/name.dart' as workout_name;
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/workout_exercise/id.dart'
    as workout_exercise_id;
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/domain/shared/domain_event_collection.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercise/sets_count.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/domain/workout/workout_exercises.dart';
import 'package:overload/infrastructure/persistence/repositories/exercise_repository.dart';
import 'package:overload/infrastructure/persistence/repositories/session_repository.dart';
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
        version: 3,
        onCreate: (db, version) async {
          await createDatabase(db);
          await seedDatabase(db);
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
        units TEXT NULL
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
        workout TEXT NULL,
        start_date TEXT NULL,
        end_date TEXT NULL,
        exercises TEXT NULL
      )
    ''');
  }

  static FutureOr<void> seedDatabase(sqflite.Database db) async {
    // Create exercises
    ExerciseRepository exerciseRepository = ExerciseRepository(db: db);
    List<Exercise> exercises = [
      Exercise(
        domainEvents: DomainEventsCollection(),
        id: Id.create(),
        name: Name.fromString("Pull-ups"),
        units: Units.fromUnitList([Unit.reps]),
      ),
      Exercise(
        domainEvents: DomainEventsCollection(),
        id: Id.create(),
        name: Name.fromString("Dips"),
        units: Units.fromUnitList([Unit.reps]),
      ),
      Exercise(
        domainEvents: DomainEventsCollection(),
        id: Id.create(),
        name: Name.fromString("Chest press"),
        units: Units.fromUnitList([Unit.reps, Unit.kgs]),
      ),
      Exercise(
        domainEvents: DomainEventsCollection(),
        id: Id.create(),
        name: Name.fromString("Shoulder press"),
        units: Units.fromUnitList([Unit.reps, Unit.kgs]),
      ),
      Exercise(
        domainEvents: DomainEventsCollection(),
        id: Id.create(),
        name: Name.fromString("Biceps curls"),
        units: Units.fromUnitList([Unit.reps, Unit.kgs]),
      ),
      Exercise(
        domainEvents: DomainEventsCollection(),
        id: Id.create(),
        name: Name.fromString("Lat pulldown"),
        units: Units.fromUnitList([Unit.reps, Unit.kgs]),
      ),
      Exercise(
        domainEvents: DomainEventsCollection(),
        id: Id.create(),
        name: Name.fromString("Row"),
        units: Units.fromUnitList([Unit.reps, Unit.kgs]),
      ),
    ];
    for (Exercise exercise in exercises) {
      await exerciseRepository.add(exercise);
    }

    // Create workout
    WorkoutRepository workoutRepository = WorkoutRepository(db: db);
    workout_id.Id workoutId = workout_id.Id.create();
    Workout workout = Workout(
      domainEvents: DomainEventsCollection(),
      id: workoutId,
      name: workout_name.Name.fromString("Full body"),
      notes: Notes.fromString("Focus on a lot of reps"),
      exercises: WorkoutExercises(
        value: [
          WorkoutExercise(
            id: workout_exercise_id.Id.create(),
            workoutId: workoutId,
            index: WorkoutExerciseIndex(value: 1),
            exercise: exercises[0],
            setsCount: SetsCount(value: 3),
            notes: Notes.fromString("Focus on a lot of reps"),
          ),
          WorkoutExercise(
            id: workout_exercise_id.Id.create(),
            workoutId: workoutId,
            index: WorkoutExerciseIndex(value: 2),
            exercise: exercises[1],
            setsCount: SetsCount(value: 3),
            notes: Notes.fromString("Focus on a lot of reps"),
          ),
          WorkoutExercise(
            id: workout_exercise_id.Id.create(),
            workoutId: workoutId,
            index: WorkoutExerciseIndex(value: 3),
            exercise: exercises[2],
            setsCount: SetsCount(value: 3),
            notes: Notes.fromString("Focus on a lot of reps"),
          ),
          WorkoutExercise(
            id: workout_exercise_id.Id.create(),
            workoutId: workoutId,
            index: WorkoutExerciseIndex(value: 4),
            exercise: exercises[3],
            setsCount: SetsCount(value: 3),
            notes: Notes.fromString("Focus on a lot of reps"),
          ),
          WorkoutExercise(
            id: workout_exercise_id.Id.create(),
            workoutId: workoutId,
            index: WorkoutExerciseIndex(value: 5),
            exercise: exercises[4],
            setsCount: SetsCount(value: 3),
            notes: Notes.fromString("Focus on a lot of reps"),
          ),
          WorkoutExercise(
            id: workout_exercise_id.Id.create(),
            workoutId: workoutId,
            index: WorkoutExerciseIndex(value: 6),
            exercise: exercises[5],
            setsCount: SetsCount(value: 3),
            notes: Notes.fromString("Focus on a lot of reps"),
          ),
        ],
      ),
    );
    await workoutRepository.add(workout);
  }
}
