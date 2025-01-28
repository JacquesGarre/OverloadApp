import 'package:flutter/material.dart';
import 'package:overload/application/session/get_sessions_query/get_sessions_query.dart';
import 'package:overload/application/session/get_sessions_query/get_sessions_query_handler.dart';
import 'package:overload/application/session/start_session_command/start_session_command.dart';
import 'package:overload/application/session/start_session_command/start_session_command_handler.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/workout/id.dart';

class SessionProvider with ChangeNotifier {
  final StartSessionCommandHandler startSessionCommandHandler;
  final GetSessionsQueryHandler getSessionsQueryHandler;

  SessionProvider({
    required this.startSessionCommandHandler,
    required this.getSessionsQueryHandler,
  });

  List _sessions = [];
  List get sessions => _sessions;

  Future<void> loadSessions() async {
    GetSessionsQuery query = GetSessionsQuery();
    _sessions = await getSessionsQueryHandler.invoke(query);
    notifyListeners();
  }

  Future<Session> startSession(Id id) async {
    try {
      StartSessionCommand command = StartSessionCommand(
        workoutId: id.toString(),
      );
      Session session = await startSessionCommandHandler.invoke(command);
      await loadSessions();
      return session;
    } catch (e) {
      rethrow;
    }
  }
}
