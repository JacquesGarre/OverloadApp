import 'package:overload/domain/workout/goal/metrics_progressions.dart';
import 'package:overload/domain/workout/set/set_index.dart';

class SetProgression {
  final SetIndex index;
  final MetricsProgressions progressions;

  SetProgression({
    required this.index,
    required this.progressions,
  });
}
