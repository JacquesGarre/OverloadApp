import 'dart:convert';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/domain/shared/domain_event_interface.dart';
import 'package:uuid/uuid.dart';

class SessionExerciseRemovedDomainEvent implements DomainEventInterface {
  final UuidValue _aggregateId;
  final UuidValue _eventId;
  final DateTime _occuredAt;
  final Session _session;
  final SessionExercise _sessionExercise;
  static const String _eventName = "SessionExerciseRemovedDomainEvent";

  SessionExerciseRemovedDomainEvent._(
    this._aggregateId,
    this._eventId,
    this._occuredAt,
    this._session,
    this._sessionExercise,
  );

  @override
  UuidValue aggregateId() {
    return _aggregateId;
  }

  @override
  UuidValue eventId() {
    return _eventId;
  }

  @override
  String eventName() {
    return _eventName;
  }

  @override
  DateTime occuredAt() {
    return _occuredAt;
  }

  static SessionExerciseRemovedDomainEvent fromSessionAndSessionExercise(
      Session session, SessionExercise sessionExercise) {
    String uuid = const Uuid().v4();
    UuidValue eventId = UuidValue.fromString(uuid);
    DateTime occuredAt = DateTime.now();
    return SessionExerciseRemovedDomainEvent._(
      session.id().value(),
      eventId,
      occuredAt,
      session,
      sessionExercise,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventName': _eventName,
      'aggregateId': _aggregateId.toString(),
      'eventId': _eventId.toString(),
      'occuredAt': _occuredAt.toString(),
      'session': _session.toJson(),
      'session_exercise': _sessionExercise.toJson(),
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  Session session() {
    return _session;
  }
}
