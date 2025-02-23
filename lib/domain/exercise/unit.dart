import 'package:logger/logger.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_unit_exception.dart';
import 'package:overload/domain/exercise/unit_type.dart';

class Unit {
  final String _name;
  final bool _canBeNegative;
  final UnitType _type;

  const Unit._({
    required String name,
    required bool canBeNegative,
    required UnitType type,
  })  : _name = name,
        _canBeNegative = canBeNegative,
        _type = type;

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

  String name() {
    return _name;
  }

  bool canBeNegative() {
    return _canBeNegative;
  }

  UnitType type() {
    return _type;
  }

  static List<Unit> all() {
    return List.unmodifiable([
      Unit.kgs,
      Unit.reps,
      Unit.kmh,
      Unit.kms,
    ]);
  }

  static Unit fromString(String name) {
    for (Unit availableUnit in all()) {
      if (availableUnit.name().toLowerCase() == name.toLowerCase()) {
        return availableUnit;
      }
    }
    Logger().e("[InvalidExerciseUnitException] $name");
    throw InvalidExerciseUnitException();
  }

  bool equals(Unit unit) {
    return name() == unit.name();
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
  int get hashCode => name().hashCode;

  @override
  String toString() { 
    return name();
  }

  num defaultValue() {
    switch(type()) {
      case UnitType.double:
        return 0.00;
      case UnitType.integer:
        return 0;
      default:
        throw InvalidExerciseUnitException();
    }
  }
}
