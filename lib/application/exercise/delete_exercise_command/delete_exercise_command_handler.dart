import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command.dart';
import 'package:overload/domain/exercise/exception/exercise_not_found_exception.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/interface/exercise_repository_interface.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';

class DeleteExerciseCommandHandler {

  final ExerciseRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  DeleteExerciseCommandHandler({required this.repository, required this.domainEventBus});

  Future<void> invoke(DeleteExerciseCommand command) async {
    Id id = Id.fromString(command.id);
    Exercise? exercise = await repository.ofId(id);
    if (exercise == null) {
      throw ExerciseNotFoundException();
    }
    exercise.delete(); 
    await repository.delete(exercise);
    domainEventBus.publish(exercise.domainEvents);
  }
}
