import 'package:faker/faker.dart';
import 'package:overload/domain/workout/set/metric.dart';

import '../../exercise/unit_stub.dart';

class MetricStub {
  static Metric random() {
    return Metric(
      value: faker.randomGenerator.decimal(),
      unit: UnitStub.random(),
    );
  }
}
