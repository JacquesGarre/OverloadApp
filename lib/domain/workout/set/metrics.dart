import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/workout/set/metric.dart';

class Metrics {
  final List<Metric> _value;

  Metrics({
    required List<Metric> value,
  }) : _value = List.unmodifiable(value);

  List<Metric> value() {
    return _value;
  }

  static Metrics fromExercise(Exercise exercise) {
    List<Metric> value = [];
    for (Unit unit in exercise.units().value()) {
      value.add(Metric.fromUnit(unit));
    }
    return Metrics(value: value);
  }

  Metric? findByUnit(Unit unit) {
    for (Metric metric in _value) {
      if (metric.unit().equals(unit)) {
        return metric;
      }
    }
    return null;
  }

  Metrics updateMetric(Metric metric) {
    List<Metric> newValue = List.from(_value);
    for (int i = 0; i < newValue.length; i++) {
      if (newValue[i].unit().equals(metric.unit())) {
        newValue[i] = metric;
        break;
      }
    }
    return Metrics(value: newValue);
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> json = [];
    for (Metric metric in _value) {
      json.add(metric.toJson());
    }
    return json;
  }

  static Metrics fromJson(List<Map<String, dynamic>> jsons) {
    List<Metric> value = [];
    for (Map<String, dynamic> json in jsons) {
      value.add(Metric.fromJson(json));
    }
    return Metrics(value: value);
  }
}
