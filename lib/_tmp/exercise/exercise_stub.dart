import 'package:overload/domain/exercise/exercise.dart';

import 'name_stub.dart';
import 'units_stub.dart';

class ExerciseStub {
  static Exercise random() {
    return Exercise.create(
      NameStub.random(),
      UnitsStub.random(),
    );
  }
}
