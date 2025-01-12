import 'package:overload/domain/exercise/exception/invalid_exercise_unit_exception.dart';

class Unit {
  final String value;

  static const Unit kgs = Unit._('Kgs');
  static const Unit reps = Unit._('Reps');
  static const Unit restTime = Unit._('Rest time');

  const Unit._(this.value);

  static List<Unit> all() {
    return [Unit.kgs, Unit.reps, Unit.restTime];
  }

  static Unit fromString(String value) {
    assertValid(value);
    return Unit._(value); 
  }

  bool equals(Unit unit) {
    return value == unit.value;
  }

  static assertValid(String value) {
    Unit unit = Unit._(value);
    for(Unit availableUnit in all()) {
      if (availableUnit.equals(unit)) {
        return;
      }
    }
    throw InvalidExerciseUnitException();
  }
}
