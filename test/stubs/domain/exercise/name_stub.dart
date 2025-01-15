import 'package:overload/domain/exercise/name.dart';
import 'package:faker/faker.dart';

class NameStub {
  static Name random() {
    return Name.fromString(faker.sport.name());
  }
}