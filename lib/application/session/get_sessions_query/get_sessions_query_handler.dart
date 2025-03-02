import 'package:overload/application/session/get_sessions_query/get_sessions_query.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';

class GetSessionsQueryHandler {
  final SessionRepositoryInterface repository;

  GetSessionsQueryHandler({required this.repository});

  Future<List<Session>> invoke(GetSessionsQuery query) async {
    List<Session> sessions = await repository.findAll(query.limit, query.offset);
    return sessions;
  }
}
