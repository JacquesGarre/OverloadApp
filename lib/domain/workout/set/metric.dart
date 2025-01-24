import 'package:overload/domain/exercise/unit.dart';

class Metric {
  final num? _value;
  final Unit _unit;

  Metric({
    required Unit unit,
    num? value,
  })  : _value = value,
        _unit = unit;

  num? value() {
    return _value;
  }

  Unit unit() {
    return _unit;
  }

  static Metric fromUnit(Unit unit) {
    return Metric(unit: unit);
  }

  @override
  String toString() { // TODO: Remove, just for logs
    return "$_value ${_unit.name()}";
  }

  num defaultValue() {
    return _unit.defaultValue();
  }

}
