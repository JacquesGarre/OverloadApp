import 'package:overload/domain/exercise/exception/invalid_exercise_unit_exception.dart';
import 'package:overload/domain/exercise/unit_type.dart';

class Unit {
  final String name;
  final bool canBeNegative;
  final UnitType type;

  static const Unit kgs = Unit._(
    name: 'Kgs',
    canBeNegative: true,
    type: UnitType.double,
  );
  static const Unit reps = Unit._(
    name: 'Reps',
    canBeNegative: false,
    type: UnitType.integer,
  );
  static const Unit kmh = Unit._(
    name: 'Km/h',
    canBeNegative: false,
    type: UnitType.double,
  );
  static const Unit kms = Unit._(
    name: 'Kms',
    canBeNegative: false,
    type: UnitType.double,
  );

  const Unit._({
    required this.name,
    required this.canBeNegative,
    required this.type,
  });

  static List<Unit> all() {
    return [
      Unit.kgs,
      Unit.reps,
      Unit.kmh,
      Unit.kms,
    ];
  }

  static Unit fromString(String name) {
    for (Unit availableUnit in all()) {
      if (availableUnit.name == name) {
        return availableUnit;
      }
    }
    throw InvalidExerciseUnitException();
  }

  bool equals(Unit unit) {
    return name == unit.name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Unit) {
      return equals(other);
    }
    return false;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}
