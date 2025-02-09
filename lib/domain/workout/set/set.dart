import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/set/metrics.dart';

class Set {
  final SetIndex _index;
  final Metrics _metrics;
  final bool _isDone;

  Set({
    required SetIndex index,
    required Metrics metrics,
    required bool isDone,
  })  : _index = index,
        _metrics = metrics,
        _isDone = isDone;

  SetIndex index() {
    return _index;
  }

  Metrics metrics() {
    return _metrics;
  }

  bool isDone() {
    return _isDone;
  }

  static Set fromSetIndexAndExercise(SetIndex index, Exercise exercise) {
    Metrics metrics = Metrics.fromExercise(exercise);
    return Set(index: index, metrics: metrics, isDone: false);
  }

  // TODO: Refactor this, so ugly...
  Set update(int cellIndex, String value) {
    bool setDone = false;
    if (cellIndex > metrics().count()) {
      setDone = value == "true";
      return Set(index: index(), metrics: metrics(), isDone: setDone);
    }
    Metric metric = metrics().value()[cellIndex - 1];
    num? updatedValue = value != "" ? num.tryParse(value) : null;
    Metric updatedMetric = Metric(unit: metric.unit(), value: updatedValue); 
    Metrics updatedMetrics = metrics().updateMetric(updatedMetric);
    return Set(index: index(), metrics: updatedMetrics, isDone: isDone());
  }

  Map<String, dynamic> toJson() {
    return {
      "set_index": _index.value(),
      "metrics": _metrics.toJson(),
      "is_done": _isDone
    };
  }

  static Set fromJson(Map<String, dynamic> json) {
    return Set(
      index: SetIndex(value: json["set_index"]),
      metrics: Metrics.fromJson(
        (json["metrics"] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList(),
      ),
      isDone: json["is_done"] ?? false,
    );
  }

  num finishedVolume() {
    if (!_isDone) {
      return 0;
    }
    Metric? kgsMetric = _metrics.findByUnit(Unit.kgs);
    if (kgsMetric == null || kgsMetric.value() == null) {
      return 0;
    }
    Metric? repsMetric = _metrics.findByUnit(Unit.reps);
    if (repsMetric == null || repsMetric.value() == null) {
      return 0;
    }
    return repsMetric.value()! * kgsMetric.value()!;
  }
}
