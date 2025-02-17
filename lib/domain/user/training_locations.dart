import 'package:overload/domain/user/exception/invalid_training_location_exception.dart';

enum TrainingLocationValue {
  gym,
  home,
  outdoors,
  mixed,
}

class TrainingLocations {
  final List<TrainingLocationValue> _value;

  TrainingLocations({required List<TrainingLocationValue> value})
      : _value = value;

  List<TrainingLocationValue> value() {
    return _value;
  }

  List<String> toStringList() {
    return _value.map((e) {
      switch (e) {
        case TrainingLocationValue.gym:
          return "Gym";
        case TrainingLocationValue.home:
          return "Home";
        case TrainingLocationValue.outdoors:
          return "Outdoors";
        case TrainingLocationValue.mixed:
          return "Mixed";
        default:
          throw InvalidTrainingLocationException();
      }
    }).toList();
  }

  static TrainingLocations fromStringList(List<String> trainingTypes) {
    List<TrainingLocationValue> value = [];
    for (String trainingType in trainingTypes) {
      switch (trainingType) {
        case "Gym":
          value.add(TrainingLocationValue.gym);
        case "Home":
          value.add(TrainingLocationValue.home);
        case "Outdoors":
          value.add(TrainingLocationValue.outdoors);
        case "Mixed":
          value.add(TrainingLocationValue.mixed);
        default:
          throw InvalidTrainingLocationException();
      }
    }
    return TrainingLocations(value: value);
  }

  static TrainingLocations all() {
    List<TrainingLocationValue> all = [
      TrainingLocationValue.gym,
      TrainingLocationValue.home,
      TrainingLocationValue.outdoors,
      TrainingLocationValue.mixed,
    ];
    return TrainingLocations(value: all);
  }
}
