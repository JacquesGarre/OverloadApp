import 'package:overload/domain/user/exception/invalid_fitness_goal_exception.dart';

enum FitnessGoalValue {
  loseWeight,
  buildMuscle,
  improveEndurance,
  increaseStrength,
  enhanceFlexibilityMobility,
  generalFitness
}

class FitnessGoals {
  final List<FitnessGoalValue> _value;

  FitnessGoals({required List<FitnessGoalValue> value}) : _value = value;

  List<FitnessGoalValue> value() {
    return _value;
  }

  List<String> toStringList() {
    return _value.map((e) {
      switch (e) {
        case FitnessGoalValue.loseWeight:
          return "Lose Weight";
        case FitnessGoalValue.buildMuscle:
          return "Build Muscle";
        case FitnessGoalValue.improveEndurance:
          return "Improve Endurance";
        case FitnessGoalValue.increaseStrength:
          return "Increase Strength";
        case FitnessGoalValue.enhanceFlexibilityMobility:
          return "Enhance Flexibility & Mobility";
        case FitnessGoalValue.generalFitness:
          return "General Fitness";
        default:
          throw InvalidFitnessGoalException();
      }
    }).toList();
  }

  static FitnessGoals all() {
    List<FitnessGoalValue> all = [
      FitnessGoalValue.loseWeight,
      FitnessGoalValue.buildMuscle,
      FitnessGoalValue.improveEndurance,
      FitnessGoalValue.increaseStrength,
      FitnessGoalValue.enhanceFlexibilityMobility,
      FitnessGoalValue.generalFitness
    ];
    return FitnessGoals(value: all);
  }
}
