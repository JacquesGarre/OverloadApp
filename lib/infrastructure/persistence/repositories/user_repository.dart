import 'package:overload/domain/user/user.dart';
import 'package:overload/domain/user/user_repository_interface.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository implements UserRepositoryInterface {
  final Database db;

  static const String table = 'users';

  UserRepository({required this.db});

  @override
  Future<void> add(User user) async {
    await db.insert(table, user.toJson());
  }

  @override
  Future<void> delete(User user) async {
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [user.id().toString()],
    );
  }

  @override
  Future<User?> findCurrentUser() async {
    List<Map<String, Object?>> usersJsons = await db.query(table);
    if (usersJsons.isEmpty) {
      return null;
    }
    List<User> users = [];
    for (Map<String, Object?> userJson in usersJsons) {
      users.add(User.fromJson(userJson));
    }
    return users.first;
  }

  @override
  Future<void> update(User user) async {
    await db.update(
      table,
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id().toString()],
    );
  }
}
