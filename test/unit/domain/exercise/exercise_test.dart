import 'package:flutter_test/flutter_test.dart';
import 'package:overload/domain/exercise/domain_events/exercise_created_domain_event.dart';
import 'package:overload/domain/exercise/domain_events/exercise_deleted_domain_event.dart';
import 'package:overload/domain/exercise/domain_events/exercise_updated_domain_event.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';

import '../../../stubs/domain/exercise/name_stub.dart';
import '../../../stubs/domain/exercise/units_stub.dart';

void main() {
  group('Exercise class tests', () {
    late Name name;
    late Units units;

    setUp(() {
      name = NameStub.random();
      units = UnitsStub.random();
    });

    test('create generates a valid Exercise and publishes an event', () {
      final exercise = Exercise.create(name, units);

      // Verify properties
      expect(exercise.name.value, name.value);
      expect(exercise.units.value, containsAll(units.value));
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
      final newName = NameStub.random();
      final newUnits = UnitsStub.random();

      final updatedExercise = exercise.update(newName, newUnits);

      // Verify new Exercise properties
      expect(updatedExercise.name.value, newName.value);
      expect(updatedExercise.units.value, containsAll(newUnits.value));
      expect(updatedExercise.id, exercise.id); // ID should remain the same

      // Verify domain event
      final events = updatedExercise.domainEvents.all();
      expect(events.length, 2); // Should include created + updated events
      expect(events.last, isA<ExerciseUpdatedDomainEvent>());

      final event = events.last as ExerciseUpdatedDomainEvent;
      expect(event.aggregateId(), exercise.id.value);
      expect(event.exercise.name.value, newName.value);
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
