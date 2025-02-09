class IsBodyWeightExercise {

  final bool _value;

  IsBodyWeightExercise({required bool value}) : _value = value;

  bool value() {
    return _value;
  } 

  static IsBodyWeightExercise fromString(String value) {
    return IsBodyWeightExercise(value: value == "true");
  }
}