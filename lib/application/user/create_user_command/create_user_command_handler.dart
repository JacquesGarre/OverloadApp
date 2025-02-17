import 'package:overload/application/user/create_user_command/create_user_command.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/user/age.dart';
import 'package:overload/domain/user/exception/user_already_exists_exception.dart';
import 'package:overload/domain/user/gender.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/domain/user/user_repository_interface.dart';
import 'package:overload/domain/user/username.dart';
import 'package:overload/domain/user/weight.dart';

class CreateUserCommandHandler {
  final UserRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  CreateUserCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<void> invoke(CreateUserCommand command) async {
    User? existingUser = await repository.findCurrentUser();
    if (existingUser != null) {
      throw UserAlreadyExistsException();
    }
    Username username = Username.fromString(command.username);
    Age age = Age.fromInt(command.age);
    Weight weight = Weight.fromNum(command.weight);
    Gender gender = Gender.fromString(command.gender);
    User user = User.create(username, age, weight, gender);
    await repository.add(user);
    domainEventBus.publish(user.domainEvents());
  }
}
