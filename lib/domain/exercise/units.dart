import 'package:overload/domain/exercise/unit.dart';

class Units {
  final List<Unit> value;

  Units._({required this.value});

  static Units fromUnitList(List<Unit> value) {
    return Units._(value: value);
  }

  List<String> toStringList() {
    List<String> strings = [];
    for(Unit unit in value) {
      strings.add(unit.value);
    }
    return strings;
  }

  static Units all() {
    return Units._(value: Unit.all());
  }

}
