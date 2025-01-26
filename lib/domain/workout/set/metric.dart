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

  num defaultValue() {
    return _unit.defaultValue();
  }

  Map<String, dynamic> toJson() {
    return {
      "value": _value,
      "unit": _unit.name(),
    };
  }

  static Metric fromJson(Map<String, dynamic> json) {
    return Metric(
      unit: Unit.fromString(json["unit"]),
      value: json["value"],
    );
  }
}
