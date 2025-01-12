import 'package:overload/application/exercise/add_exercise_command/add_exercise_command.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';

class AddExerciseCommandHandler {

  Exercise invoke(AddExerciseCommand command) {
    Name name = Name.fromString(command.name);
    Units units = Units.fromStringList(command.units);
    Exercise exercise = Exercise.create(name, units);

    // validate not twice the same unit
    // validate id not existing already
    // validate name not existing already

    return exercise;
  }

}