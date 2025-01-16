import 'package:faker/faker.dart';
import 'package:overload/domain/workout/goal/metric_progression.dart';

import '../../exercise/unit_stub.dart';
import 'operator_stub.dart';

class MetricProgressionStub {
  static MetricProgression random() {
    return MetricProgression(
      operator: OperatorStub.random(),
      value: faker.randomGenerator.integer(5),
      unit: UnitStub.random(),
    );
  }
}
