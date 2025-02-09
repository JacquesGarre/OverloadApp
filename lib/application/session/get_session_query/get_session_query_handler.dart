import 'package:overload/application/session/get_session_query/get_session_query.dart';
import 'package:overload/domain/session/exception/session_not_found_exception.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';

class GetSessionQueryHandler {
  final SessionRepositoryInterface repository;

  GetSessionQueryHandler({required this.repository});

  Future<Session> invoke(GetSessionQuery query) async {
    Id id = Id.fromString(query.id);
    Session? session = await repository.ofId(id);
    if (session == null) {
      throw SessionNotFoundException();
    }
    return session;
  }
}
