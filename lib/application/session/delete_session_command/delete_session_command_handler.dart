import 'package:overload/application/session/delete_session_command/delete_session_command.dart';
import 'package:overload/domain/session/exception/session_not_found_exception.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';

class DeleteSessionCommandHandler {
  final SessionRepositoryInterface sessionRepository;
  final DomainEventBusInterface domainEventBus;

  DeleteSessionCommandHandler({
    required this.sessionRepository,
    required this.domainEventBus,
  });

  Future<void> invoke(DeleteSessionCommand command) async {
    if (command.id == null) {
      return;
    }
    Id sessionId = Id.fromString(command.id!);
    Session? session = await sessionRepository.ofId(sessionId);
    if (session == null) {
      throw SessionNotFoundException();
    }
    session.delete();
    await sessionRepository.delete(session);
    domainEventBus.publish(session.domainEvents());
  }
}
