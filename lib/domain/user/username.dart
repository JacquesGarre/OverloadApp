import 'package:overload/domain/user/exception/username_cannot_be_empty_exception.dart';
import 'package:overload/domain/user/exception/username_too_long_exception.dart';

class Username {

  final String _value;
  static const int maxLength = 30;

  Username._({required String value}) : _value = value;

  static Username fromString(String value) {
    assertValid(value);
    return Username._(value: value);
  }

  static assertValid(String value) {
    if (value.isEmpty) {
      throw UsernameCannotBeEmptyException();
    }
    if (value.length > Username.maxLength) {
      throw UsernameTooLongException();
    }
  }

  String value() {
    return _value;
  }
}