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
    return _value.map((e) => e.name).toList();
  }
}
