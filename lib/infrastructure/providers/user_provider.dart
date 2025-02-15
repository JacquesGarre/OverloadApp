import 'package:flutter/material.dart';
import 'package:overload/domain/user/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  Future<void> loadUser() async {
    notifyListeners();
  }
}
