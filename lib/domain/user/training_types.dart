enum TrainingTypeValue {
  weightlifting,
  bodyweigth,
  cardio,
  hiit,
  yoga,
  pilates,
  crossfit,
  mixedWorkouts,
}

class TrainingTypes {

  final List<TrainingTypeValue> _value;

  TrainingTypes({required List<TrainingTypeValue> value}) : _value = value;

  List<TrainingTypeValue> value() {
    return _value;
  }

}