import 'package:logger/logger.dart';
import 'package:overload/application/user/update_user_command/update_user_command.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/user/exception/user_not_found_exception.dart';
import 'package:overload/domain/user/fitness_goals.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/domain/user/user_repository_interface.dart';
import 'package:overload/domain/user/workout_duration_preference.dart';
import 'package:overload/domain/user/workout_weekly_days.dart';

class UpdateUserCommandHandler {
  final UserRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  UpdateUserCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<void> invoke(UpdateUserCommand command) async {
    User? user = await repository.findCurrentUser();
    if (user == null) {
      throw UserNotFoundException();
    }
    FitnessGoals? fitnessGoals;
    if (command.fitnessGoals != null) {
      fitnessGoals = FitnessGoals.fromStringList(command.fitnessGoals!);
    }
    WorkoutDurationPreference? workoutDurationPreference;
    if (command.workoutDurationPreference != null) {
      workoutDurationPreference =
          WorkoutDurationPreference(value: command.workoutDurationPreference!);
    }
    WorkoutWeeklyDays? workoutWeeklyDays;
    if (command.workoutWeeklyDays != null) {
      workoutWeeklyDays = WorkoutWeeklyDays.fromInt(command.workoutWeeklyDays!);
    }
    User updatedUser = user.update(
      newWorkoutDurationPreference: workoutDurationPreference,
      newFitnessGoals: fitnessGoals,
      newWorkoutWeeklyDays: workoutWeeklyDays,
    );
    await repository.update(updatedUser);
    domainEventBus.publish(updatedUser.domainEvents());
  }
}
