import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/application/session/add_session_exercise_command/add_session_exercise_command.dart';
import 'package:overload/application/session/add_session_exercise_command/add_session_exercise_command_handler.dart';
import 'package:overload/application/session/delete_session_command/delete_session_command.dart';
import 'package:overload/application/session/delete_session_command/delete_session_command_handler.dart';
import 'package:overload/application/session/finish_session_command/finish_session_command.dart';
import 'package:overload/application/session/finish_session_command/finish_session_command_handler.dart';
import 'package:overload/application/session/get_current_session_query/get_current_session_query.dart';
import 'package:overload/application/session/get_current_session_query/get_current_session_query_handler.dart';
import 'package:overload/application/session/get_session_query/get_session_query.dart';
import 'package:overload/application/session/get_session_query/get_session_query_handler.dart';
import 'package:overload/application/session/get_sessions_query/get_sessions_query.dart';
import 'package:overload/application/session/get_sessions_query/get_sessions_query_handler.dart';
import 'package:overload/application/session/remove_session_exercise_command/remove_session_exercise_command.dart';
import 'package:overload/application/session/remove_session_exercise_command/remove_session_exercise_command_handler.dart';
import 'package:overload/application/session/start_session_command/start_session_command.dart';
import 'package:overload/application/session/start_session_command/start_session_command_handler.dart';
import 'package:overload/application/session/update_session_exercise_command/update_session_exercise_command.dart';
import 'package:overload/application/session/update_session_exercise_command/update_session_exercise_command_handler.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/domain/workout/id.dart' as workout;

class SessionProvider with ChangeNotifier {
  final StartSessionCommandHandler startSessionCommandHandler;
  final GetSessionsQueryHandler getSessionsQueryHandler;
  final GetSessionQueryHandler getSessionQueryHandler;
  final GetCurrentSessionQueryHandler getCurrentSessionQueryHandler;
  final DeleteSessionCommandHandler deleteSessionCommandHandler;
  final UpdateSessionExerciseCommandHandler updateSessionExerciseCommandHandler;
  final RemoveSessionExerciseCommandHandler removeSessionExerciseCommandHandler;
  final AddSessionExerciseCommandHandler addSessionExerciseCommandHandler;
  final FinishSessionCommandHandler finishSessionCommandHandler;

  SessionProvider({
    required this.startSessionCommandHandler,
    required this.getSessionsQueryHandler,
    required this.getCurrentSessionQueryHandler,
    required this.deleteSessionCommandHandler,
    required this.updateSessionExerciseCommandHandler,
    required this.removeSessionExerciseCommandHandler,
    required this.getSessionQueryHandler,
    required this.addSessionExerciseCommandHandler,
    required this.finishSessionCommandHandler,
  });

  Session? _currentSession;
  Session? get currentSession => _currentSession;

  List _sessions = [];
  List get sessions => _sessions;

  Future<void> loadCurrentSession() async {
    GetCurrentSessionQuery query = GetCurrentSessionQuery();
    _currentSession = await getCurrentSessionQueryHandler.invoke(query);
    notifyListeners();
    Logger().e("Listeners notified with exercises: ${_currentSession?.sessionExercises().count()}");
  }

  Future<void> loadSessions() async {
    GetSessionsQuery query = GetSessionsQuery();
    _sessions = await getSessionsQueryHandler.invoke(query);
    notifyListeners();
  }

  Future<Session> startSession(workout.Id id) async {
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

  Future<Session> getSessionById(Id sessionId) async {
    try {
      GetSessionQuery query = GetSessionQuery(id: sessionId.toString());
      Session session = await getSessionQueryHandler.invoke(query);
      return session;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCurrentSession() async {
    try {
      DeleteSessionCommand command = DeleteSessionCommand(
        id: _currentSession?.id().toString(),
      );
      await deleteSessionCommandHandler.invoke(command);
      await loadCurrentSession();
      await loadSessions();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSession(Session session) async {
    try {
      DeleteSessionCommand command = DeleteSessionCommand(
        id: session.id().toString(),
      );
      await deleteSessionCommandHandler.invoke(command);
      await loadCurrentSession();
      await loadSessions();
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> updateSessionExercise(Id id, SessionExercise exercise) async {
    try {
      UpdateSessionExerciseCommand command = UpdateSessionExerciseCommand(
        id: id,
        exercise: exercise,
      );
      Session updatedSession =
          await updateSessionExerciseCommandHandler.invoke(command);
      await loadCurrentSession();
      await loadSessions();
      return updatedSession;
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> addSessionExercise(Id id, SessionExercise exercise) async {
    try {
      AddSessionExerciseCommand command = AddSessionExerciseCommand(
        id: id,
        exercise: exercise,
      );
      Session updatedSession =
          await addSessionExerciseCommandHandler.invoke(command);
      await loadCurrentSession();
      await loadSessions();
      return updatedSession;
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> removeSessionExercise(Id id, SessionExercise exercise) async {
    try {
      RemoveSessionExerciseCommand command = RemoveSessionExerciseCommand(
        id: id,
        exercise: exercise,
      );
      Session updatedSession = await removeSessionExerciseCommandHandler.invoke(command);
      await loadCurrentSession();
      await loadSessions();
      return updatedSession;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> finishCurrentSession() async {
    if (_currentSession == null) {
      return;
    }
    try {
      FinishSessionCommand command = FinishSessionCommand(
        id: _currentSession!.id().toString(),
      );
      await finishSessionCommandHandler.invoke(command);
      _currentSession = null;
      await loadSessions();
    } catch (e) {
      rethrow;
    }
  }
}
