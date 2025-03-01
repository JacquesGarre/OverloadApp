import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';
import 'package:overload/domain/session/id.dart';
import 'package:sqflite/sqflite.dart';

class SessionRepository implements SessionRepositoryInterface {
  final Database db;

  static const String table = 'sessions';

  SessionRepository({required this.db});

  @override
  Future<void> add(Session session) async {
    await db.insert(table, session.toJson());
  }

  @override
  Future<void> delete(Session session) async {
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [session.id().toString()],
    );
  }

  @override
  Future<List<Session>> findAll() async {
    List<Session> sessions = [];
    List<Map<String, dynamic>> sessionsJsons = await db.query(
      table,
      orderBy: 'end_date IS NULL DESC, end_date DESC',
    );
    for (Map<String, dynamic> sessionJson in sessionsJsons) {
      Session session = Session.fromJson(sessionJson);
      Session? previousSession = await findPreviousSession(session);
      if (previousSession != null) {
        session = session.setPreviousSession(previousSession);
      }
      sessions.add(session);
    }
    return sessions;
  }

  @override
  Future<void> update(Session session) async {
    await db.update(
      table,
      session.toJson(),
      where: 'id = ?',
      whereArgs: [session.id().toString()],
    );
  }

  @override
  Future<Session?> ofId(Id id) async {
    List<Map<String, Object?>> sessionsJsons = await db.query(table,
        where: 'id = ?', whereArgs: [id.toString()], limit: 1);
    if (sessionsJsons.isEmpty) {
      return null;
    }
    List<Session> sessions = [];
    for (Map<String, Object?> sessionJson in sessionsJsons) {
      sessions.add(Session.fromJson(sessionJson));
    }
    Session session = sessions.first;
    Session? previousSession = await findPreviousSession(session);
    if (previousSession != null) {
      session = session.setPreviousSession(previousSession);
    }
    return session;
  }

  @override
  Future<Session?> findCurrentSession() async {
    List<Map<String, Object?>> sessionsJsons = await db.query(
      table,
      where: 'end_date IS NULL',
      limit: 1,
    );
    if (sessionsJsons.isEmpty) {
      return null;
    }
    List<Session> sessions = [];
    for (Map<String, Object?> sessionJson in sessionsJsons) {
      sessions.add(Session.fromJson(sessionJson));
    }
    Session session = sessions.first;
    Session? previousSession = await findPreviousSession(session);
    if (previousSession != null) {
      session = session.setPreviousSession(previousSession);
    }
    return session;
  }

  @override
  Future<Session?> findPreviousSession(Session session) async {
    List<Map<String, Object?>> sessionsJsons = await db.query(table,
        where: 'workout_id = ? AND start_date < ?',
        whereArgs: [
          session.workoutId().toString(),
          session.startDate().toString()
        ],
        orderBy: 'start_date DESC',
        limit: 1);
    if (sessionsJsons.isEmpty) {
      return null;
    }
    List<Session> sessions = [];
    for (Map<String, Object?> sessionJson in sessionsJsons) {
      sessions.add(Session.fromJson(sessionJson));
    }
    return sessions.first;
  }

  @override
  Future<Session?> findLastFinishedSession() async {
    List<Map<String, Object?>> sessionsJsons = await db.query(
      table,
      where: 'end_date IS NOT NULL',
      limit: 1,
      orderBy: 'session_number DESC',
    );
    if (sessionsJsons.isEmpty) {
      return null;
    }
    List<Session> sessions = [];
    for (Map<String, Object?> sessionJson in sessionsJsons) {
      sessions.add(Session.fromJson(sessionJson));
    }
    Session session = sessions.first;
    Session? previousSession = await findPreviousSession(session);
    if (previousSession != null) {
      session = session.setPreviousSession(previousSession);
    }
    return session;
  }
}
