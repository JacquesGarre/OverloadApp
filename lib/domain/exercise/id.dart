import 'package:uuid/uuid.dart';

class Id {
  final UuidValue value;

  Id._(this.value);

  static Id create() {
    String uuid = const Uuid().v4();
    UuidValue value = UuidValue.fromString(uuid);
    return Id._(value);
  }

  bool equals(Id id) {
    return id.toString() == toString();
  }

  static Id fromString(String value) {
    UuidValue uuid = UuidValue.fromString(value);
    return Id._(uuid);
  }

  @override
  String toString() {
    return value.uuid.toString();
  }
}
