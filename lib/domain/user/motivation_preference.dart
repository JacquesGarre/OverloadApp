enum MotivationPreferenceValue {
  motivationalAndEncouraging,
  noNonsenseAndDirect,
  technicalAndDetailed,
}

class MotivationPreference {

  final MotivationPreferenceValue _value;

  MotivationPreference({required MotivationPreferenceValue value}) : _value = value;

  MotivationPreferenceValue value() {
    return _value;
  }

  @override
  String toString() {
    return _value.name;
  }
}