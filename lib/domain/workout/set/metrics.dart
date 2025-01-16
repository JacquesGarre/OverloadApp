import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/workout/set/metric.dart';

class Metrics {
  final List<Metric> value;

  Metrics({
    required this.value,
  });

  static Metrics fromExercise(Exercise exercise) {
    List<Metric> value = [];
    for (Unit unit in exercise.units.value) {
      value.add(Metric.fromUnit(unit));
    }
    return Metrics(value: value);
  }
}
