import 'package:faker/faker.dart';
import 'package:overload/domain/workout/name.dart';

class NameStub {
  static Name random() {
    return Name.fromString(faker.lorem.sentence());
  }
}