import 'package:flutter_test/flutter_test.dart';
import 'package:overload/domain/exercise/exception/duplicate_exercise_unit_exception.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/units.dart';

void main() {
  group('Exercise Units class tests', () {
    test('fromUnitList creates a valid Units instance', () {
      final units = Units.fromUnitList([
        Unit.kgs,
        Unit.reps,
        Unit.restTime,
      ]);
      expect(units.value.length, 3);
      expect(units.value.contains(Unit.kgs), isTrue);
      expect(units.value.contains(Unit.reps), isTrue);
      expect(units.value.contains(Unit.restTime), isTrue);
    });

    test('fromUnitList throws DuplicateExerciseUnitException for duplicate units', () {
      expect(
        () => Units.fromUnitList([Unit.kgs, Unit.reps, Unit.kgs]),
        throwsA(isA<DuplicateExerciseUnitException>()),
      );
    });

    test('fromStringList creates a valid Units instance from strings', () {
      final units = Units.fromStringList(['Kgs', 'Reps', 'Rest time']);
      expect(units.value.length, 3);
      expect(units.value.contains(Unit.kgs), isTrue);
      expect(units.value.contains(Unit.reps), isTrue);
      expect(units.value.contains(Unit.restTime), isTrue);
    });

    test('fromStringList throws DuplicateExerciseUnitException for duplicate strings', () {
      expect(
        () => Units.fromStringList(['Kgs', 'Reps', 'Kgs']),
        throwsA(isA<DuplicateExerciseUnitException>()),
      );
    });

    test('toStringList converts Units to a list of strings', () {
      final units = Units.fromUnitList([
        Unit.kgs,
        Unit.reps,
        Unit.restTime,
      ]);
      final strings = units.toStringList();
      expect(strings, ['Kgs', 'Reps', 'Rest time']);
    });

    test('all returns all predefined units', () {
      final allUnits = Units.all();
      final predefinedUnits = Unit.all();
      expect(allUnits.value.length, predefinedUnits.length);
      for (final unit in predefinedUnits) {
        expect(allUnits.value.contains(unit), isTrue);
      }
    });
  });
}
