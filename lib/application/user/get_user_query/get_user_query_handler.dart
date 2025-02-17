import 'package:overload/application/user/get_user_query/get_user_query.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/domain/user/user_repository_interface.dart';

class GetUserQueryHandler {
  final UserRepositoryInterface repository;

  GetUserQueryHandler({required this.repository});

  Future<User?> invoke(GetUserQuery query) async {
    User? user = await repository.findCurrentUser();
    return user;
  }
}
