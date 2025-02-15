enum FitnessLevelValue {
  beginner,
  intermediate,
  advanced
}

class FitnessLevel {

  final FitnessLevelValue _value;

  FitnessLevel({required FitnessLevelValue value}) : _value = value;

  FitnessLevelValue value() {
    return _value;
  }

  @override 
  String toString() {
    return _value.name;
  }
} 