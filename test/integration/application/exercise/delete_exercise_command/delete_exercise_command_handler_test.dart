import 'package:event_bus/event_bus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command.dart';
import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command_handler.dart';
import 'package:overload/domain/exercise/exception/exercise_not_found_exception.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/interface/exercise_repository_interface.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/infrastructure/bus/domain_event_bus.dart';
import 'package:overload/infrastructure/persistence/database.dart';
import 'package:overload/infrastructure/persistence/repositories/exercise_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

void main() {
  late sqflite_ffi.Database db;
  late ExerciseRepositoryInterface repository;
  late DeleteExerciseCommandHandler handler;

  setUp(() async {
    // Initialize sqflite for testing
    sqflite_ffi.sqfliteFfiInit();
    sqflite_ffi.databaseFactory = sqflite_ffi.databaseFactoryFfi;

    // Create an in-memory SQLite database for testing
    db = await sqflite_ffi.openDatabase(
      sqflite_ffi.inMemoryDatabasePath,
      version: 1,
      onCreate: Database.createDatabase,
    );
    repository = ExerciseRepository(db: db);
    final eventBus = DomainEventBus(eventBus: EventBus());
    handler = DeleteExerciseCommandHandler(
        repository: repository, domainEventBus: eventBus);
  });

  tearDown(() async {
    await db.close();
  });

  test('deletes an exercise successfully', () async {
    // Add an exercise to the database
    Name name = Name.fromString('Existing Exercise');
    Units units = Units.fromUnitList([Unit.kgs, Unit.reps]);
    final exercise = Exercise.create(name, units);
    await repository.add(exercise);

    // Delete the exercise
    final command = DeleteExerciseCommand(id: exercise.id.toString());
    await handler.invoke(command);

    // Verify the exercise is removed from the database
    final exercises = await repository.findAll();
    expect(exercises.isEmpty, isTrue);
  });

  test('throws ExerciseNotFoundException for non-existent exercise', () async {
    final command = DeleteExerciseCommand(id: '123e4567-e89b-12d3-a456-426614174000');

    expect(
      () async => await handler.invoke(command),
      throwsA(isA<ExerciseNotFoundException>()),
    );
  });
}
