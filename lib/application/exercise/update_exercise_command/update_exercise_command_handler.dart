import 'package:overload/application/exercise/update_exercise_command/update_exercise_command.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';

class UpdateExerciseCommandHandler {

  Exercise invoke(UpdateExerciseCommand command) {
    Id id = Id.fromString(command.id);
    Name name = Name.fromString(command.name);
    Units units = Units.fromStringList(command.units);
    Exercise exercise = Exercise(id: id, name: name, units: units); // TODO: replace by update in domain
    return exercise;
  }

}