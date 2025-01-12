import 'package:flutter_test/flutter_test.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_name_exception.dart';
import 'package:overload/domain/exercise/name.dart';

void main() {
  group('Exercise Name class tests', () {
    test('fromString creates a valid Name instance for non-empty string', () {
      const input = 'Valid Name';
      final name = Name.fromString(input);
      expect(name.value, 'Valid Name');
    });

    test('fromString trims whitespace around input', () {
      const input = '   Valid Name   ';
      final name = Name.fromString(input);
      expect(name.value, 'Valid Name');
    });

    test('assertValid throws InvalidExerciseNameException for empty input', () {
      expect(() => Name.fromString(''), throwsA(isA<InvalidExerciseNameException>()));
    });

    test('equals returns true for Names with the same value', () {
      final name1 = Name.fromString('Same Name');
      final name2 = Name.fromString('Same Name');
      expect(name1.equals(name2), isTrue);
    });

    test('equals returns false for Names with different values', () {
      final name1 = Name.fromString('Name 1');
      final name2 = Name.fromString('Name 2');
      expect(name1.equals(name2), isFalse);
    });
  });
}
