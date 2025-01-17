import 'package:flutter_test/flutter_test.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_unit_exception.dart';
import 'package:overload/domain/exercise/unit.dart';

void main() {
  group('Exercise Unit class tests', () {
    test('fromString creates a valid Unit instance for predefined units', () {
      final unit = Unit.fromString('Kgs');
      expect(unit.name, 'Kgs');
    });

    test('fromString throws InvalidExerciseUnitException for invalid unit', () {
      expect(
        () => Unit.fromString('InvalidUnit'),
        throwsA(isA<InvalidExerciseUnitException>()),
      );
    });

    test('equals returns true for Units with the same value', () {
      final unit1 = Unit.fromString('Kgs');
      const unit2 = Unit.kgs;
      expect(unit1.equals(unit2), isTrue);
    });

    test('equals returns false for Units with different values', () {
      final unit1 = Unit.fromString('Kgs');
      final unit2 = Unit.fromString('Reps');
      expect(unit1.equals(unit2), isFalse);
    });

    test('all returns the list of predefined units', () {
      final units = Unit.all();
      expect(units.length, 2);
      expect(units.contains(Unit.kgs), isTrue);
      expect(units.contains(Unit.reps), isTrue);
    });

    // TODO: Test format, negative
  });
}
