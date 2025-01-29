import 'package:overload/application/session/get_current_session_query/get_current_session_query.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';

class GetCurrentSessionQueryHandler {
  final SessionRepositoryInterface repository;

  GetCurrentSessionQueryHandler({required this.repository});

  Future<Session?> invoke(GetCurrentSessionQuery query) async {
    Session? session = await repository.findCurrentSession();
    return session;
  }
}
