import 'package:event_bus/event_bus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command_handler.dart';
import 'package:overload/domain/exercise/exception/exercise_already_exists_exception.dart';
import 'package:overload/domain/exercise/interface/exercise_repository_interface.dart';
import 'package:overload/infrastructure/bus/domain_event_bus.dart';
import 'package:overload/infrastructure/persistence/database.dart';
import 'package:overload/infrastructure/persistence/repositories/exercise_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

void main() {
  late sqflite_ffi.Database db;
  late ExerciseRepositoryInterface repository;
  late AddExerciseCommandHandler handler;

  setUp(() async {
    // Create an in-memory SQLite database for testing
    sqflite_ffi.sqfliteFfiInit();
    sqflite_ffi.databaseFactory = sqflite_ffi.databaseFactoryFfi;
    db = await sqflite_ffi.openDatabase(
      sqflite_ffi.inMemoryDatabasePath,
      version: 1,
      onCreate: Database.createDatabase,
    );
    repository = ExerciseRepository(db: db);
    final eventBus = DomainEventBus(eventBus: EventBus());
    handler = AddExerciseCommandHandler(
        repository: repository, domainEventBus: eventBus);
  });

  tearDown(() async {
    await db.close();
  });

  test('adds a new exercise successfully', () async {
    final command = AddExerciseCommand(
      name: 'Test Exercise',
      units: ['Kgs', 'Reps'],
    );

    // Invoke the command handler
    await handler.invoke(command);

    // Verify the exercise is stored in the database
    final exercises = await repository.findAll();
    expect(exercises.length, 1);
    expect(exercises.first.name.value, 'Test Exercise');
    expect(exercises.first.units.toStringList(), ['Kgs', 'Reps']);
  });

  test('throws ExerciseAlreadyExistsException for duplicate exercise name',
      () async {
    final command = AddExerciseCommand(
      name: 'Test Exercise',
      units: ['Kgs', 'Reps'],
    );

    // Add the first exercise
    await handler.invoke(command);

    // Attempt to add a duplicate exercise
    expect(
      () async => await handler.invoke(command),
      throwsA(isA<ExerciseAlreadyExistsException>()),
    );

    // Verify only one exercise exists in the database
    final exercises = await repository.findAll();
    expect(exercises.length, 1);
  });
}
