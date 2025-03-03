import 'package:overload/domain/exercise/exception/exercise_name_too_long_exception.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_name_exception.dart';

class Name {

  final String _value;
  static const int maxLength = 50;

  Name._({required String value}) : _value = value;

  static Name fromString(String value) {
    String trimmedValue = value.trim();
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
    if (value.isEmpty) {
      throw InvalidExerciseNameException();
    }
    if (value.length > Name.maxLength) {
      throw ExerciseNameTooLongException();
    }
  }
}
