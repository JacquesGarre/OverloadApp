import 'package:overload/application/user/delete_user_command/delete_user_command.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/domain/user/user_repository_interface.dart';

class DeleteUserCommandHandler {
  final UserRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  DeleteUserCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

 Future<void> invoke(DeleteUserCommand command) async {
  User? existingUser = await repository.findCurrentUser();
  if (existingUser == null) {
    return;
  }
  existingUser.delete();
  await repository.delete(existingUser);
  domainEventBus.publish(existingUser.domainEvents());
 }

}