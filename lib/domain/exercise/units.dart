import 'package:overload/domain/exercise/unit.dart';

class Units {
  final List<Unit> value;

  Units._({required this.value});

  static Units fromUnitList(List<Unit> value) {
    return Units._(value: value);
    // TODO validate that no duplicates
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
    return Units._(value: value);
    // TODO validate that no duplicates
  }
}
