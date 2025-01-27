import 'package:overload/application/workout/delete_workout_command/delete_workout_command.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/workout/exception/workout_not_found_exception.dart';
import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_repository_interface.dart';

class DeleteWorkoutCommandHandler {

  final WorkoutRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  DeleteWorkoutCommandHandler({required this.repository, required this.domainEventBus});

  Future<void> invoke(DeleteWorkoutCommand command) async {
    Id id = Id.fromString(command.id);
    Workout? workout = await repository.ofId(id);
    if (workout == null) {
      throw WorkoutNotFoundException();
    }
    workout.delete(); 
    await repository.delete(workout);
    domainEventBus.publish(workout.domainEvents());
  }
}
