import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/set/metrics.dart';

class Set {
  final SetIndex index;
  final Metrics metrics;

  Set({
    required this.index,
    required this.metrics,
  });
}
