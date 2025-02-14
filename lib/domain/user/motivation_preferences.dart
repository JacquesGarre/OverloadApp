enum MotivationPreferenceValue {
  motivationalAndEncouraging,
  noNonsenseAndDirect,
  technicalAndDetailed,
}

class MotivationPreferences {

  final List<MotivationPreferenceValue> _value;

  MotivationPreferences({required List<MotivationPreferenceValue> value}) : _value = value;

  List<MotivationPreferenceValue> value() {
    return _value;
  }
}