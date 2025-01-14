import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/workout/goal/operator.dart';

class MetricProgression {
  final Operator operator;
  final num value;
  final Unit unit;

  MetricProgression({
    required this.operator,
    required this.value,
    required this.unit,
  });
}
