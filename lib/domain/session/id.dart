import 'package:overload/domain/session/exception/invalid_session_id_exception.dart';
import 'package:uuid/uuid.dart';

class Id {
  final UuidValue _value;

  Id._({required UuidValue value}) : _value = value;

  static Id create() {
    String uuid = const Uuid().v4();
    assertValid(uuid);
    UuidValue value = UuidValue.fromString(uuid);
    return Id._(value: value);
  }

  UuidValue value() {
    return _value;
  }

  bool equals(Id id) {
    return id.toString() == toString();
  }

  static Id fromString(String value) {
    assertValid(value);
    UuidValue uuid = UuidValue.fromString(value);
    return Id._(value: uuid);
  }

  static assertValid(String value) {
    if (Uuid.isValidUUID(fromString: value)) {
      return;
    }
    throw InvalidSessionIdException();
  }

  @override
  String toString() {
    return _value.uuid.toString();
  }
}
