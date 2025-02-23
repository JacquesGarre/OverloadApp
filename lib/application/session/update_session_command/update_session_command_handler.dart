import 'package:overload/application/session/update_session_command/update_session_command.dart';
import 'package:overload/domain/session/exception/session_not_found_exception.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/shared/notes.dart';

class UpdateSessionCommandHandler {
  final SessionRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  UpdateSessionCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<Session> invoke(UpdateSessionCommand command) async {
    Id id = Id.fromString(command.id);
    Session? session = await repository.ofId(id);
    if (session == null) {
      throw SessionNotFoundException();
    }
    Notes? notes = Notes.fromString(command.notes);
    DateTime? startDate;
    if (command.startDate != null) {
      startDate = command.startDate;
    }
    DateTime? endDate;
    if (command.endDate != null) {
      endDate = command.endDate;
    }
    Session updatedSession = session.update(notes, startDate, endDate);
    await repository.update(updatedSession);
    domainEventBus.publish(updatedSession.domainEvents());
    return updatedSession;
  }
}
