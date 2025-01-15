import 'package:faker/faker.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/set/metrics.dart';

import 'metric_stub.dart';

class MetricsStub {
  static Metrics random() {
    List<Metric> value = [];
    for (var i = 0; i <= faker.randomGenerator.integer(4); i++) {
      value.add(MetricStub.random());
    }
    return Metrics(value: value);
  }
}
