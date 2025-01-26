import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/set/metrics.dart';

class Set {
  final SetIndex _index;
  final Metrics _metrics;

  Set({
    required SetIndex index,
    required Metrics metrics,
  })  : _index = index,
        _metrics = metrics;

  SetIndex index() {
    return _index;
  }

  Metrics metrics() {
    return _metrics;
  }

  static Set fromSetIndexAndExercise(SetIndex index, Exercise exercise) {
    Metrics metrics = Metrics.fromExercise(exercise);
    return Set(index: index, metrics: metrics);
  }

  Set updateMetric(Metric newMetric) {
    Metrics newMetrics = _metrics.updateMetric(newMetric);
    return Set(index: _index, metrics: newMetrics);
  }

  Map<String, dynamic> toJson() {
    return {
      "set_index": _index.value(),
      "metrics": _metrics.toJson(),
    };
  }

  static Set fromJson(Map<String, dynamic> json) {
    return Set(
      index: SetIndex(value: json["set_index"] ),
      metrics: Metrics.fromJson(
        (json["metrics"] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList(),
        ),
    );
  }
}
