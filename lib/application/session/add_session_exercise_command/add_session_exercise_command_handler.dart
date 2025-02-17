import 'package:overload/application/session/add_session_exercise_command/add_session_exercise_command.dart';
import 'package:overload/domain/session/exception/session_not_found_exception.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';

class AddSessionExerciseCommandHandler {
  final SessionRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  AddSessionExerciseCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<Session> invoke(AddSessionExerciseCommand command) async {
    Session? session = await repository.ofId(command.id);
    if (session == null) {
      throw SessionNotFoundException();
    }
    Session updatedSession = session.addSessionExercise(command.exercise);
    await repository.update(updatedSession);
    domainEventBus.publish(updatedSession.domainEvents());
    return updatedSession;
  }
}
