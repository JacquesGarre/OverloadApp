import 'package:overload/domain/exercise/exception/invalid_exercise_name_exception.dart';

class Name {
  final String _value;

  Name._({required String value}) : _value = value;

  static Name fromString(String value) {
    String trimmedValue = value.trim(); // TODO: Add a max length here
    assertValid(trimmedValue);
    return Name._(value: trimmedValue);
  }

  bool equals(Name name) {
    return _value == name.value();
  }

  String value() {
    return _value;
  }

  static void assertValid(String value) {
    if (value.isNotEmpty) {
      return;
    }
    throw InvalidExerciseNameException();
  }
}
