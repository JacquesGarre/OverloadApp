import 'package:flutter/material.dart';
import 'package:overload/application/user/create_user_command/create_user_command.dart';
import 'package:overload/application/user/create_user_command/create_user_command_handler.dart';
import 'package:overload/application/user/delete_user_command/delete_user_command.dart';
import 'package:overload/application/user/delete_user_command/delete_user_command_handler.dart';
import 'package:overload/application/user/get_user_query/get_user_query.dart';
import 'package:overload/application/user/get_user_query/get_user_query_handler.dart';
import 'package:overload/application/user/update_user_command/update_user_command.dart';
import 'package:overload/application/user/update_user_command/update_user_command_handler.dart';
import 'package:overload/domain/user/user.dart';

class UserProvider with ChangeNotifier {
  final CreateUserCommandHandler createUserCommandHandler;
  final DeleteUserCommandHandler deleteUserCommandHandler;
  final UpdateUserCommandHandler updateUserCommandHandler;
  final GetUserQueryHandler getUserQueryHandler;

  UserProvider({
    required this.createUserCommandHandler,
    required this.deleteUserCommandHandler,
    required this.updateUserCommandHandler,
    required this.getUserQueryHandler,
  });

  User? _user;
  User? get user => _user;

  Future<void> loadUser() async {
    _user = await getUserQueryHandler.invoke(GetUserQuery());
    notifyListeners();
  }

  Future<void> createUser(Map<String, dynamic> formData) async {
    try {
      CreateUserCommand command = CreateUserCommand(
        username: formData["username"],
        age: formData["age"],
        weight: formData["weight"],
        gender: formData["gender"],
      );
      await createUserCommandHandler.invoke(command);
      await loadUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserFitnessGoals(Map<String, dynamic> formData) async {
    try {
      UpdateUserCommand command = UpdateUserCommand(
        workoutDurationPreference: formData["workout_duration_preference"],
        fitnessGoals: formData["fitness_goals"],
        workoutWeeklyDays: formData["workout_weekly_days"],
      );
      await updateUserCommandHandler.invoke(command);
      await loadUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserFitnessExperience(
    Map<String, dynamic> formData,
  ) async {
    try {
      UpdateUserCommand command = UpdateUserCommand(
        fitnessLevel: formData["fitness_level"],
        trainingTypes: formData["training_types"],
        trainingLocations: formData["training_locations"],
        equipment: formData["equipment"],
      );
      await updateUserCommandHandler.invoke(command);
      await loadUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCurrentUser() async {
    try {
      DeleteUserCommand command = DeleteUserCommand();
      await deleteUserCommandHandler.invoke(command);
      await loadUser();
    } catch (e) {
      rethrow;
    }
  }
}
