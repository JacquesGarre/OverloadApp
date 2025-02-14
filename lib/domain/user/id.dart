import 'package:uuid/uuid.dart';

class Id {

  final String _value;

  Id._({required String value}) : _value = value;

  static Id create() {
    return Id._(value: const Uuid().v4());
  }

  String value() {
    return _value;
  }

}