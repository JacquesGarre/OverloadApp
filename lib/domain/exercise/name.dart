import 'package:overload/domain/exercise/exception/invalid_exercise_name_exception.dart';

class Name {
  final String value;

  Name._({required this.value});

  static Name fromString(String value) {
    String trimmedValue = value.trim();
    assertValid(trimmedValue);
    return Name._(value: trimmedValue);
  }

  bool equals(Name name) {
    return value == name.value;
  }

  static void assertValid(String value) {
    if (value.isNotEmpty) {
      return;
    }
    throw InvalidExerciseNameException();
  }
}
