import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/id.dart';

abstract class SessionRepositoryInterface {
  Future<void> add(Session session);
  Future<void> update(Session session);
  Future<void> delete(Session session);
  Future<Session?> ofId(Id id);
  Future<List<Session>> findAll();
  Future<Session?> findCurrentSession();
  Future<Session?> findLastFinishedSession();
  Future<Session?> findPreviousSession(Session session);
}
