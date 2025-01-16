import 'package:faker/faker.dart';
import 'package:overload/domain/workout/notes.dart';

class NotesStub {
  static Notes random() {
    return Notes(value: faker.lorem.sentence());
  }
}