import 'package:overload/application/user/update_user_command/update_user_command.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/user/age.dart';
import 'package:overload/domain/user/equipment.dart';
import 'package:overload/domain/user/exception/user_not_found_exception.dart';
import 'package:overload/domain/user/fitness_goals.dart';
import 'package:overload/domain/user/fitness_level.dart';
import 'package:overload/domain/user/gender.dart';
import 'package:overload/domain/user/training_locations.dart';
import 'package:overload/domain/user/training_types.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/domain/user/user_repository_interface.dart';
import 'package:overload/domain/user/username.dart';
import 'package:overload/domain/user/weight.dart';
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
    Username? username;
    if (command.username != null) {
      username = Username.fromString(command.username!);
    }
    Age? age;
    if (command.age != null) {
      age = Age.fromInt(command.age!);
    }
    Weight? weight;
    if (command.weight != null) {
      weight = Weight.fromNum(command.weight!);
    }
    Gender? gender;
    if (command.gender != null) {
      gender = Gender.fromString(command.gender!);
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
    FitnessLevel? fitnessLevel;
    if (command.fitnessLevel != null) {
      fitnessLevel = FitnessLevel.fromString(command.fitnessLevel!);
    }
    TrainingTypes? trainingTypes;
    if (command.trainingTypes != null) {
      trainingTypes = TrainingTypes.fromStringList(command.trainingTypes!);
    }
    TrainingLocations? trainingLocations;
    if (command.trainingLocations != null) {
      trainingLocations =
          TrainingLocations.fromStringList(command.trainingLocations!);
    }
    Equipment? equipment;
    if (command.equipment != null) {
      equipment = Equipment.fromStringList(command.equipment!);
    }
    User updatedUser = user.update(
      newUsername: username,
      newAge: age,
      newWeight: weight,
      newGender: gender,
      newWorkoutDurationPreference: workoutDurationPreference,
      newFitnessGoals: fitnessGoals,
      newWorkoutWeeklyDays: workoutWeeklyDays,
      newFitnessLevel: fitnessLevel,
      newTrainingTypes: trainingTypes,
      newTrainingLocations: trainingLocations,
      newEquipment: equipment,
    );
    await repository.update(updatedUser);
    domainEventBus.publish(updatedUser.domainEvents());
  }
}
