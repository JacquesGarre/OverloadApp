import 'package:event_bus/event_bus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:overload/application/exercise/update_exercise_command/update_exercise_command.dart';
import 'package:overload/application/exercise/update_exercise_command/update_exercise_command_handler.dart';
import 'package:overload/domain/exercise/exception/exercise_already_exists_exception.dart';
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
  late UpdateExerciseCommandHandler handler;

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
    handler = UpdateExerciseCommandHandler(
        repository: repository, domainEventBus: eventBus);
  });

  tearDown(() async {
    await db.close();
  });

  test('updates an exercise successfully', () async {
    // Add an initial exercise to the database
    Name name = Name.fromString('Test Exercise');
    Units units = Units.fromUnitList([Unit.kgs, Unit.reps]);
    final exercise = Exercise.create(name, units);
    await repository.add(exercise);

    // Update the exercise
    final command = UpdateExerciseCommand(
      id: exercise.id.toString(),
      name: 'Updated Exercise',
      units: ['Rest time'],
    );
    await handler.invoke(command);

    // Verify the exercise is updated
    final exercises = await repository.findAll();
    expect(exercises.length, 1);
    expect(exercises.first.name.value, 'Updated Exercise');
    expect(exercises.first.units.toStringList(), ['Rest time']);
  });

  test('throws ExerciseNotFoundException for non-existent exercise', () async {
    final command = UpdateExerciseCommand(
      id: '123e4567-e89b-12d3-a456-426614174000',
      name: 'Updated Exercise',
      units: ['Kgs'],
    );
    expect(
      () async => await handler.invoke(command),
      throwsA(isA<ExerciseNotFoundException>()),
    );
  });

  test('throws ExerciseAlreadyExistsException for duplicate exercise name',
      () async {

    // Add two exercises to the database
    Name name = Name.fromString('Existing Exercise');
    Units units = Units.fromUnitList([Unit.kgs, Unit.reps]);
    final exercise = Exercise.create(name, units);
    await repository.add(exercise);

    Name otherName = Name.fromString('Other Exercise');
    Units otherUnits = Units.fromUnitList([Unit.kgs, Unit.reps]);
    final exerciseToUpdate = Exercise.create(otherName, otherUnits);
    await repository.add(exerciseToUpdate);

    // Attempt to update the second exercise to the same name as the first
    final command = UpdateExerciseCommand(
      id: exerciseToUpdate.id.toString(),
      name: exercise.name.value,
      units: ['Kgs'],
    );

    expect(
      () async => await handler.invoke(command),
      throwsA(isA<ExerciseAlreadyExistsException>()),
    );

    // Verify no changes occurred
    final exercises = await repository.findAll();
    expect(exercises.length, 2);
    expect(exercises.any((e) => e.name.value == 'Other Exercise'), isTrue);
    expect(exercises.any((e) => e.name.value == 'Existing Exercise'), isTrue);
  });
}
