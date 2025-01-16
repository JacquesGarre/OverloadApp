import 'package:overload/domain/workout/set/set.dart';

import 'metrics_stub.dart';
import 'set_index_stub.dart';

class SetStub {
  static Set random() {
    return Set(
      index: SetIndexStub.random(),
      metrics: MetricsStub.random(),
    );
  }
}
