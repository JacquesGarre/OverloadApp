import 'package:overload/domain/workout/exception/invalid_workout_id_exception.dart';
import 'package:uuid/uuid.dart';

class Id {
  final UuidValue value;

  Id._(this.value);

  static Id create() {
    String uuid = const Uuid().v4();
    assertValid(uuid);
    UuidValue value = UuidValue.fromString(uuid);
    return Id._(value);
  }

  bool equals(Id id) {
    return id.toString() == toString();
  }

  static Id fromString(String value) {
    assertValid(value);
    UuidValue uuid = UuidValue.fromString(value);
    return Id._(uuid);
  }

  static assertValid(String value) {
    if (Uuid.isValidUUID(fromString: value)) {
      return;
    }
    throw InvalidWorkoutIdException();
  }

  @override
  String toString() {
    return value.uuid.toString();
  }
}
