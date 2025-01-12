import 'package:overload/application/exercise/update_exercise_command/update_exercise_command.dart';
import 'package:overload/domain/exercise/exception/exercise_already_exists_exception.dart';
import 'package:overload/domain/exercise/exception/exercise_not_found_exception.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/exercise_repository_interface.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';

class UpdateExerciseCommandHandler {
  final ExerciseRepositoryInterface repository;

  UpdateExerciseCommandHandler({required this.repository});

  Future<void> invoke(UpdateExerciseCommand command) async {
    Id id = Id.fromString(command.id);
    Exercise? exercise = await repository.ofId(id);
    if (exercise == null) {
      throw ExerciseNotFoundException(); // TODO : handle exception in view
    }
    Name newName = Name.fromString(command.name);
    Units units = Units.fromStringList(command.units);

    if (!newName.equals(exercise.name)) {
      Exercise? existingExercise = await repository.ofName(newName);
      if (existingExercise != null) {
        throw ExerciseAlreadyExistsException(); // TODO : handle exception in view
      }
    }

    Exercise updatedExercise =
        exercise.update(newName, units); // TODO : publish event
    await repository.update(updatedExercise);
  }
}
