import 'package:overload/domain/exercise/exception/invalid_exercise_name_exception.dart';

class Name {
  final String value;

  Name._({required this.value});

  static Name fromString(String value) {
    assertValid(value);
    return Name._(value: value);
  }

  bool equals(Name name) {
    return value == name.value;
  }

  static void assertValid(String value) {
    if (value.isNotEmpty) {
      return;
    }
    throw InvalidExerciseNameException(); // TODO : handle exception in view
  }

}
