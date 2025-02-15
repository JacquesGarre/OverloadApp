import 'package:flutter/material.dart';
import 'package:overload/application/user/create_user_command/create_user_command.dart';
import 'package:overload/application/user/create_user_command/create_user_command_handler.dart';
import 'package:overload/application/user/delete_user_command/delete_user_command.dart';
import 'package:overload/application/user/delete_user_command/delete_user_command_handler.dart';
import 'package:overload/domain/user/user.dart';

class UserProvider with ChangeNotifier {
  final CreateUserCommandHandler createUserCommandHandler;
  final DeleteUserCommandHandler deleteUserCommandHandler;

  UserProvider({
    required this.createUserCommandHandler,
    required this.deleteUserCommandHandler,
  });

  User? _user;
  User? get user => _user;

  Future<void> loadUser() async {
    // TODO: Query
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
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCurrentUser() async {
    try {
      DeleteUserCommand command = DeleteUserCommand();
      await deleteUserCommandHandler.invoke(command);
    } catch (e) {
      rethrow;
    }
  }
}
