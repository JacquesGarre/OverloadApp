import 'package:overload/domain/user/exception/invalid_gender_exception.dart';

class Gender {
  final String _value;

  static Gender male = Gender._(value: 'Male');
  static Gender female = Gender._(value: 'Female');
  static Gender other = Gender._(value: 'Other');

  Gender._({required String value}) : _value = value;

  String value() {
    return _value;
  }

  static Gender fromString(String value) {
    switch (value) {
      case 'Male':
        return Gender.male;
      case 'Female':
        return Gender.female;
      case 'Other':
        return Gender.other;
      default:
        throw InvalidGenderException();
    }
  }
}
