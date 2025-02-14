class Gender {

  final String _value;

  static Gender male = Gender._(value: 'Male');
  static Gender female = Gender._(value: 'Female');

  Gender._({required String value}) : _value = value;

  String value() {
    return _value;
  }
}