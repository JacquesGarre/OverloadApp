enum TrainingLocationValue {
  gym,
  home,
  outdoors,
  mixed,
}

class TrainingLocations {

  final List<TrainingLocationValue> _value;

  TrainingLocations({required List<TrainingLocationValue> value}) : _value = value;

  List<TrainingLocationValue> value() {
    return _value;
  }

}
