class CompletedProfile {

  final bool _value;

  CompletedProfile({required bool value}) : _value = value;

  bool value() {
    return _value;
  }

  static CompletedProfile fromString(String value) {
    return CompletedProfile(value: value == "true");
  }
}