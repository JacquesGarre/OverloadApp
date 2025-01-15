import 'package:faker/faker.dart';
import 'package:overload/domain/workout/set/set_index.dart';

class SetIndexStub {
  static SetIndex random() {
    return SetIndex(value: faker.randomGenerator.integer(5));
  }
}
