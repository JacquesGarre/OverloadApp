import 'package:faker/faker.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/set/metrics.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/set/set.dart';

import 'set/metrics_stub.dart';

class SetsStub {
  static Sets random() {
    List<Set> value = [];
    Metrics metrics = MetricsStub.random();
    for (var i = 1; i <= faker.randomGenerator.integer(10, min: 1); i++) {
      value.add(Set(index: SetIndex(value: i), metrics: metrics));
    }
    return Sets(value: value);
  }

  static Sets fromExercise(Exercise exercise) {
    List<Set> value = [];
    Metrics metrics = Metrics.fromExercise(exercise);
    for (var i = 1; i <= 3; i++) {
      value.add(Set(index: SetIndex(value: i), metrics: metrics));
    }
    return Sets(value: value);
  }
}
