import 'package:overload/domain/exercise/unit.dart';

class Metric {
  final num value;
  final Unit unit;

  Metric({
    required this.value,
    required this.unit,
  });

  static Metric fromUnit(Unit unit) {
    return Metric(value: 0, unit: unit);
  }

  @override
  String toString() {
    return "$value ${unit.name}";
  }
}
