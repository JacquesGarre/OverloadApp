import 'package:overload/domain/user/exception/invalid_fitness_level_exception.dart';

enum FitnessLevelValue { beginner, intermediate, advanced }

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

  static FitnessLevel fromString(String value) {
    switch (value) {
      case 'beginner':
        return FitnessLevel(value: FitnessLevelValue.beginner);
      case 'intermediate':
        return FitnessLevel(value: FitnessLevelValue.intermediate);
      case 'advanced':
        return FitnessLevel(value: FitnessLevelValue.advanced);
      default:
        throw InvalidFitnessLevelException();
    }
  }
}
