import 'package:overload/domain/exercise/exercise.dart';
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

}
