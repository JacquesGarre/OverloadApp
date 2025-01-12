import 'package:flutter_test/flutter_test.dart';
import 'package:overload/domain/exercise/domain_events/exercise_created_domain_event.dart';
import 'package:overload/domain/exercise/domain_events/exercise_deleted_domain_event.dart';
import 'package:overload/domain/exercise/domain_events/exercise_updated_domain_event.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/units.dart';

void main() {
  group('Exercise class tests', () {
    late Name name;
    late Units units;

    setUp(() {
      name = Name.fromString('Test Exercise');
      units = Units.fromUnitList([Unit.kgs, Unit.reps]);
    });

    test('create generates a valid Exercise and publishes an event', () {
      final exercise = Exercise.create(name, units);

      // Verify properties
      expect(exercise.name.value, 'Test Exercise');
      expect(exercise.units.value, containsAll([Unit.kgs, Unit.reps]));
      expect(exercise.id, isNotNull);

      // Verify domain event
      final events = exercise.domainEvents.all();
      expect(events.length, 1);
      expect(events.first, isA<ExerciseCreatedDomainEvent>());

      final event = events.first as ExerciseCreatedDomainEvent;
      expect(event.aggregateId(), exercise.id.value);
      expect(event.exercise.name.value, exercise.name.value);
    });

    test('update creates a new Exercise with updated properties and publishes an event', () {
      final exercise = Exercise.create(name, units);
      final newName = Name.fromString('Updated Exercise');
      final newUnits = Units.fromUnitList([Unit.restTime]);

      final updatedExercise = exercise.update(newName, newUnits);

      // Verify new Exercise properties
      expect(updatedExercise.name.value, 'Updated Exercise');
      expect(updatedExercise.units.value, contains(Unit.restTime));
      expect(updatedExercise.id, exercise.id); // ID should remain the same

      // Verify domain event
      final events = updatedExercise.domainEvents.all();
      expect(events.length, 2); // Should include created + updated events
      expect(events.last, isA<ExerciseUpdatedDomainEvent>());

      final event = events.last as ExerciseUpdatedDomainEvent;
      expect(event.aggregateId(), exercise.id.value);
      expect(event.exercise.name.value, 'Updated Exercise');
    });

    test('delete publishes an ExerciseDeletedDomainEvent', () {
      final exercise = Exercise.create(name, units);

      exercise.delete();

      // Verify domain event
      final events = exercise.domainEvents.all();
      expect(events.length, 2); // Should include created + deleted events
      expect(events.last, isA<ExerciseDeletedDomainEvent>());

      final event = events.last as ExerciseDeletedDomainEvent;
      expect(event.aggregateId(), exercise.id.value);
    });
  });
}
