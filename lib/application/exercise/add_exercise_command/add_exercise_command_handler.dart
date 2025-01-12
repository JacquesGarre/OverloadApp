import 'package:overload/application/exercise/add_exercise_command/add_exercise_command.dart';
import 'package:overload/domain/exercise/exception/exercise_already_exists_exception.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/exercise_repository_interface.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';

class AddExerciseCommandHandler {
  final ExerciseRepositoryInterface repository;

  AddExerciseCommandHandler({required this.repository});

  Future<void> invoke(AddExerciseCommand command) async {
    Name name = Name.fromString(command.name);
    Units units = Units.fromStringList(command.units);
    Exercise exercise = Exercise.create(name, units);
    Exercise? existingExercise = await repository.ofId(exercise.id);
    if (existingExercise != null) {
      throw ExerciseAlreadyExistsException();
    }
    existingExercise = await repository.ofName(exercise.name);
    if (existingExercise != null) {
      throw ExerciseAlreadyExistsException();
    }
    // TODO : Handle exceptions in view
    // TODO : publish events
    await repository.add(exercise);
  }
}
