import 'package:overload/domain/exercise/unit.dart';

class Metric {
  final num _value;
  final Unit _unit;

  Metric({
    required num value,
    required Unit unit,
  })  : _value = value,
        _unit = unit;

  num value() {
    return _value;
  }

  Unit unit() {
    return _unit;
  }

  static Metric fromUnit(Unit unit) {
    return Metric(value: 0, unit: unit);
  }

  @override
  String toString() {
    return "$_value ${_unit.name()}";
  }
}
