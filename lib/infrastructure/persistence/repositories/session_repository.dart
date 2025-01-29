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
    List<Map<String, dynamic>> sessionsJsons = await db.query(table); // TODO: Order by endDate DESC (NULL FIRST if possible)
    for(Map<String, dynamic> sessionJson in sessionsJsons) {
      sessions.add(Session.fromJson(sessionJson));
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
    List<Map<String, Object?>> sessionsJsons = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id.toString()],
    );    
    if(sessionsJsons.isEmpty){
      return null;
    }
    List<Session> sessions = [];
    for(Map<String, Object?> sessionJson in sessionsJsons) {
      sessions.add(Session.fromJson(sessionJson));
    }
    return sessions.first;
  }

  @override
  Future<Session?> findCurrentSession() async {
    List<Map<String, Object?>> sessionsJsons = await db.query(
      table,
      where: 'end_date IS NULL',
    );    
    if(sessionsJsons.isEmpty){
      return null;
    }
    List<Session> sessions = [];
    for(Map<String, Object?> sessionJson in sessionsJsons) {
      sessions.add(Session.fromJson(sessionJson));
    }
    return sessions.first;
  }
}