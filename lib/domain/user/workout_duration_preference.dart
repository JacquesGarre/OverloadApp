enum WorkoutDurationPreferenceValue {
  thirtyMinutes,
  fortyFiveMinutes,
  sixtyMinutes,
  moreThanSixtyMinutes
}

class WorkoutDurationPreference {

  final WorkoutDurationPreferenceValue _value;

  WorkoutDurationPreference({required WorkoutDurationPreferenceValue value}) : _value = value;

  WorkoutDurationPreferenceValue value() {
    return _value;
  }
}