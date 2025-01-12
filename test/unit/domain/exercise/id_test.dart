import 'package:flutter_test/flutter_test.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_id_exception.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Exercise Id class tests', () {
    test('create generates a valid Id instance with a valid UUID', () {
      final id = Id.create();
      expect(Uuid.isValidUUID(fromString: id.toString()), isTrue);
    });

    test('fromString creates a valid Id instance from a valid UUID string', () {
      const uuidString = '123e4567-e89b-12d3-a456-426614174000';
      final id = Id.fromString(uuidString);
      expect(id.toString(), uuidString);
    });

    test('fromString throws InvalidExerciseIdException for invalid UUID string', () {
      const invalidUuidString = 'invalid-uuid-string';
      expect(
        () => Id.fromString(invalidUuidString),
        throwsA(isA<InvalidExerciseIdException>()),
      );
    });

    test('assertValid does not throw for valid UUID', () {
      const validUuidString = '123e4567-e89b-12d3-a456-426614174000';
      expect(() => Id.assertValid(validUuidString), returnsNormally);
    });

    test('assertValid throws InvalidExerciseIdException for invalid UUID', () {
      const invalidUuidString = 'invalid-uuid-string';
      expect(
        () => Id.assertValid(invalidUuidString),
        throwsA(isA<InvalidExerciseIdException>()),
      );
    });

    test('equals returns true for Ids with the same UUID', () {
      const uuidString = '123e4567-e89b-12d3-a456-426614174000';
      final id1 = Id.fromString(uuidString);
      final id2 = Id.fromString(uuidString);
      expect(id1.equals(id2), isTrue);
    });

    test('equals returns false for Ids with different UUIDs', () {
      final id1 = Id.create();
      final id2 = Id.create();
      expect(id1.equals(id2), isFalse);
    });

    test('toString returns the correct UUID string', () {
      const uuidString = '123e4567-e89b-12d3-a456-426614174000';
      final id = Id.fromString(uuidString);
      expect(id.toString(), uuidString);
    });
  });
}
