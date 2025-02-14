import 'package:overload/domain/workout/exception/invalid_workout_name_exception.dart';
import 'package:overload/domain/workout/exception/workout_name_too_long_exception.dart';

class Name {
  final String _value;
  static const int maxLength = 50;

  Name._({required String value}) : _value = value;

  String value() {
    return _value;
  }

  static Name fromString(String value) {
    String trimmedValue = value.trim();
    assertValid(trimmedValue);
    return Name._(value: trimmedValue);
  }

  bool equals(Name name) {
    return value() == name.value();
  }

  static void assertValid(String value) {
    if (value.isEmpty) {
      throw InvalidWorkoutNameException();
    }
    if (value.length > Name.maxLength) {
      throw WorkoutNameTooLongException();
    }
  }
}
