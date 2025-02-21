import 'package:overload/application/session/finish_session_command/finish_session_command.dart';
import 'package:overload/domain/session/exception/session_not_found_exception.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';

class FinishSessionCommandHandler {
  final SessionRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  FinishSessionCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<void> invoke(FinishSessionCommand command) async {
    if (command.id == null) {
      return;
    }
    Id sessionId = Id.fromString(command.id!);
    Session? session = await repository.ofId(sessionId);
    if (session == null) {
      throw SessionNotFoundException();
    }
    Session finishedSession = session.finish();
    await repository.update(finishedSession);
    domainEventBus.publish(finishedSession.domainEvents());
  }
}
