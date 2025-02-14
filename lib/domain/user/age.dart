import 'package:overload/domain/user/exception/invalid_age_exception.dart';

class Age {
  final int _value;

  Age._({required int value}) : _value = value;

  static Age fromInt(int value) {
    assertValid(value);
    return Age._(value: value);
  }

  static assertValid(int value) {
    if (value <= 0) {
      throw InvalidAgeException();
    }
    if (value > 120) {
      throw InvalidAgeException();
    }
  }

  int value() {
    return _value;
  }
}