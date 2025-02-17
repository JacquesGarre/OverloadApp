import 'package:overload/domain/user/exception/invalid_training_type_exception.dart';

enum TrainingTypeValue {
  weightlifting,
  bodyweight,
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

  List<String> toStringList() {
    return _value.map((e) {
      switch (e) {
        case TrainingTypeValue.weightlifting:
          return "Weight lifting";
        case TrainingTypeValue.bodyweight:
          return "Body weight";
        case TrainingTypeValue.cardio:
          return "Cardio";
        case TrainingTypeValue.hiit:
          return "HIIT";
        case TrainingTypeValue.yoga:
          return "Yoga";
        case TrainingTypeValue.pilates:
          return "Pilates";
        case TrainingTypeValue.crossfit:
          return "Crossfit";
        case TrainingTypeValue.mixedWorkouts:
          return "Mixed workouts";
        default:
          throw InvalidTrainingTypeException();
      }
    }).toList();
  }

  static TrainingTypes fromStringList(List<String> trainingTypes) {
    List<TrainingTypeValue> value = [];
    for (String trainingType in trainingTypes) {
      switch (trainingType) {
        case "Weight lifting":
          value.add(TrainingTypeValue.weightlifting);
        case "Body weight":
          value.add(TrainingTypeValue.bodyweight);
        case "Cardio":
          value.add(TrainingTypeValue.cardio);
        case "HIIT":
          value.add(TrainingTypeValue.hiit);
        case "Yoga":
          value.add(TrainingTypeValue.yoga);
        case "Pilates":
          value.add(TrainingTypeValue.pilates);
        case "Crossfit":
          value.add(TrainingTypeValue.crossfit);
        case "Mixed workouts":
          value.add(TrainingTypeValue.mixedWorkouts);
        default:
          throw InvalidTrainingTypeException();
      }
    }
    return TrainingTypes(value: value);
  }

  static TrainingTypes all() {
    List<TrainingTypeValue> all = [
      TrainingTypeValue.weightlifting,
      TrainingTypeValue.bodyweight,
      TrainingTypeValue.cardio,
      TrainingTypeValue.hiit,
      TrainingTypeValue.yoga,
      TrainingTypeValue.pilates,
      TrainingTypeValue.crossfit,
      TrainingTypeValue.mixedWorkouts,
    ];
    return TrainingTypes(value: all);
  }
}
