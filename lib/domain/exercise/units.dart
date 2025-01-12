import 'package:overload/domain/exercise/exception/duplicate_exercise_unit_exception.dart';
import 'package:overload/domain/exercise/unit.dart';

class Units {
  final List<Unit> value;

  Units._({required this.value});

  static Units fromUnitList(List<Unit> value) {
    assertValid(value);
    return Units._(value: value);
  }

  List<String> toStringList() {
    List<String> strings = [];
    for (Unit unit in value) {
      strings.add(unit.value);
    }
    return strings;
  }

  static Units all() {
    return Units._(value: Unit.all());
  }

  static Units fromStringList(List<String> units) {
    List<Unit> value = [];
    for (String unit in units) {
      value.add(Unit.fromString(unit));
    }
    assertValid(value);
    return Units._(value: value);
  }

  static void assertValid(List<Unit> value) {
    final set = value.map((unit) => unit.value).toSet();
    if (set.length != value.length) {
      throw DuplicateExerciseUnitException();
    }
  }
}
