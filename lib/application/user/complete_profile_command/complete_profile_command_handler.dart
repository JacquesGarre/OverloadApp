import 'package:overload/application/user/complete_profile_command/complete_profile_command.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/user/exception/user_not_found_exception.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/domain/user/user_repository_interface.dart';

class CompleteProfileCommandHandler {
  final UserRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  CompleteProfileCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<void> invoke(CompleteProfileCommand command) async {
    User? user = await repository.findCurrentUser();
    if (user == null) {
      throw UserNotFoundException();
    }
    User updatedUser = user.completeProfile();
    await repository.update(updatedUser);
    domainEventBus.publish(updatedUser.domainEvents());
  }
}
