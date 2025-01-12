import 'package:overload/application/exercise/update_exercise_command/update_exercise_command.dart';
import 'package:overload/domain/exercise/exception/exercise_already_exists_exception.dart';
import 'package:overload/domain/exercise/exception/exercise_not_found_exception.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/interface/exercise_repository_interface.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';

class UpdateExerciseCommandHandler {
  
  final ExerciseRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  UpdateExerciseCommandHandler({required this.repository, required this.domainEventBus});

  Future<void> invoke(UpdateExerciseCommand command) async {
    Id id = Id.fromString(command.id);
    Exercise? exercise = await repository.ofId(id);
    if (exercise == null) {
      throw ExerciseNotFoundException();
    }
    Name newName = Name.fromString(command.name);
    Units units = Units.fromStringList(command.units);
    if (!newName.equals(exercise.name)) {
      Exercise? existingExercise = await repository.ofName(newName);
      if (existingExercise != null) {
        throw ExerciseAlreadyExistsException();
      }
    }
    Exercise updatedExercise = exercise.update(
      newName,
      units,
    ); 
    await repository.update(updatedExercise);
    domainEventBus.publish(updatedExercise.domainEvents);
  }
}
