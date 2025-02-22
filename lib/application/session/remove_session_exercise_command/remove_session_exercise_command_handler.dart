import 'package:overload/application/session/remove_session_exercise_command/remove_session_exercise_command.dart';
import 'package:overload/domain/session/exception/session_not_found_exception.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';

class RemoveSessionExerciseCommandHandler {
  final SessionRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  RemoveSessionExerciseCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<Session> invoke(RemoveSessionExerciseCommand command) async {
    Session? session = await repository.ofId(command.id);
    if (session == null) {
      throw SessionNotFoundException();
    }
    Session updatedSession = session.removeSessionExercise(command.exercise);
    await repository.update(updatedSession);
    domainEventBus.publish(updatedSession.domainEvents());
    return updatedSession;
  }
}
