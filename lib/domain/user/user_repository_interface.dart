import 'package:overload/domain/user/user.dart';

abstract class UserRepositoryInterface {
  Future<void> add(User user);
  Future<void> update(User user);
  Future<void> delete(User user);
  Future<User?> findCurrentUser();
}
