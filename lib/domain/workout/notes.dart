import 'package:overload/domain/workout/exception/notes_too_long_exception.dart';

class Notes {

  final String _value;
  static const int maxLength = 500;

  Notes._({required String value}) : _value = value.trim();

  String value() {
    return _value;
  }

  static Notes? fromString(String? value) {
    if (value == null || value.trim() == "") {
      return null;
    }
    assertValid(value);
    return Notes._(value: value);
  }

  static assertValid(String value) {
    if (value.length > Notes.maxLength) {
      throw NotesTooLongException();
    }
  }

}