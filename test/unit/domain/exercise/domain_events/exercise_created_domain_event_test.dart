import 'package:flutter_test/flutter_test.dart';
import 'package:overload/domain/exercise/domain_events/exercise_created_domain_event.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('ExerciseCreatedDomainEvent tests', () {
    late Exercise exercise;

    setUp(() {
      exercise = Exercise.create(
        Name.fromString('Test Exercise'),
        Units.fromUnitList([Unit.kgs, Unit.reps]),
      );
    });

    test('fromExercise creates a valid ExerciseCreatedDomainEvent', () {
      final event = ExerciseCreatedDomainEvent.fromExercise(exercise);
      expect(event.aggregateId(), exercise.id.value);
      expect(event.eventName(), 'ExerciseCreatedDomainEvent');
      expect(event.exercise.name.value, exercise.name.value);
      expect(event.exercise.units.value, exercise.units.value);
      expect(event.occuredAt().isBefore(DateTime.now()), isTrue);
      expect(event.eventId(), isA<UuidValue>());
    });

    test('toJson returns correct JSON representation', () {
      final event = ExerciseCreatedDomainEvent.fromExercise(exercise);
      final json = event.toJson();
      expect(json['eventName'], 'ExerciseCreatedDomainEvent');
      expect(json['aggregateId'], exercise.id.toString());
      expect(json['eventId'], isNotNull);
      expect(json['occuredAt'], isNotNull);
      expect(json['exercise']['id'], exercise.id.toString());
      expect(json['exercise']['name'], exercise.name.value);
      expect(json['exercise']['units'], ['Kgs', 'Reps']);
    });

    test('toString returns correct JSON string', () {
      final event = ExerciseCreatedDomainEvent.fromExercise(exercise);
      final jsonString = event.toString();
      expect(jsonString, isNotNull);
      expect(jsonString, contains('"eventName":"ExerciseCreatedDomainEvent"'));
      expect(jsonString, contains('"aggregateId":"${exercise.id}"'));
      expect(jsonString, contains('"exercise":{"id":"${exercise.id}"'));
    });
  });
}