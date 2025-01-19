import 'package:logger/logger.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/set/metrics.dart';

class Set {
  final SetIndex index;
  final Metrics metrics;

  Set({
    required this.index,
    required this.metrics,
  });

  static Set fromSetIndexAndExercise(SetIndex index, Exercise exercise) {
    Metrics metrics = Metrics.fromExercise(exercise);
    return Set(index: index, metrics: metrics);
  }

  Set updateMetric(Metric newMetric) {
    Metrics newMetrics = metrics.updateMetric(newMetric);
    return Set(index: index, metrics: newMetrics);
  }

  @override
  String toString() {
    String string = "Set ${index.value} :";
    for (Metric metric in metrics.value) {
      string = "$string ${metric.toString()}";
    }
    return string;
  }
}
