import 'package:overload/application/session/update_session_exercise_command/update_session_exercise_command.dart';
import 'package:overload/domain/session/exception/session_not_found_exception.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';

class UpdateSessionExerciseCommandHandler {
  final SessionRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  UpdateSessionExerciseCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<Session> invoke(UpdateSessionExerciseCommand command) async {
    Session? session = await repository.ofId(command.id);
    if (session == null) {
      throw SessionNotFoundException();
    }
    Session updatedSession = session.updateSessionExercise(command.exercise);
    await repository.update(updatedSession);
    domainEventBus.publish(updatedSession.domainEvents());
    return updatedSession;
  }
}
