import 'dart:convert';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/shared/domain_event_interface.dart';
import 'package:uuid/uuid.dart';

class SessionUpdatedDomainEvent implements DomainEventInterface {

  final UuidValue _aggregateId;
  final UuidValue _eventId;
  final DateTime _occuredAt;
  final Session _session;
  static const String _eventName = "SessionUpdatedDomainEvent";

  SessionUpdatedDomainEvent._(this._aggregateId, this._eventId, this._occuredAt, this._session);

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

  static SessionUpdatedDomainEvent fromSession(Session session) {
    String uuid = const Uuid().v4();
    UuidValue eventId = UuidValue.fromString(uuid);
    DateTime occuredAt = DateTime.now();
    return SessionUpdatedDomainEvent._(session.id().value(), eventId, occuredAt, session);
  }

  Map<String, dynamic> toJson() {
    return {
      'eventName': _eventName,
      'aggregateId': _aggregateId.toString(),
      'eventId': _eventId.toString(),
      'occuredAt': _occuredAt.toString(),
      'session': _session.toJson()
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