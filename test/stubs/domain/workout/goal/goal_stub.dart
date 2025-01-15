import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goal/goal.dart';
import 'package:overload/domain/workout/goal/goal_progression.dart';
import 'package:overload/domain/workout/goal/goal_progressions.dart';
import 'package:overload/domain/workout/goal/metric_progression.dart';
import 'package:overload/domain/workout/goal/metrics_progressions.dart';
import 'package:overload/domain/workout/goal/set_progression.dart';
import 'package:overload/domain/workout/goal/sets_progressions.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/set/set.dart';

import 'operator_stub.dart';

class GoalStub {
  static Goal fromExerciseAndSets(Exercise exercise, Sets sets) {
    List<SetProgression> setsProgressionsValue = [];
    for (Set set in sets.value) {
      List<MetricProgression> metricsProgressionsValue = [];
      for (Metric metric in set.metrics.value) {
        metricsProgressionsValue.add(
          MetricProgression(
            operator: OperatorStub.random(),
            value: metric.value + 1,
            unit: metric.unit,
          ),
        );
      }
      MetricsProgressions progressions = MetricsProgressions(
        value: metricsProgressionsValue,
      );
      setsProgressionsValue.add(
        SetProgression(
          index: set.index,
          progressions: progressions,
        ),
      );
    }

    SetsProgressions setsProgressions = SetsProgressions(
      value: setsProgressionsValue,
    );
    List<GoalProgression> goalProgressionValue = [
      GoalProgression(
        setsProgressions: setsProgressions,
      )
    ];
    GoalProgressions progressions = GoalProgressions(
      value: goalProgressionValue,
    );
    return Goal(
      targetSets: sets,
      progressions: progressions,
    );
  }
}
