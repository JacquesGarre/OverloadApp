import 'dart:convert';
import 'package:overload/domain/shared/domain_event_interface.dart';
import 'package:overload/domain/user/user.dart';
import 'package:uuid/uuid.dart';

class UserDeletedDomainEvent implements DomainEventInterface {

  final UuidValue _aggregateId;
  final UuidValue _eventId;
  final DateTime _occuredAt;
  final User _user;
  static const String _eventName = "UserDeletedDomainEvent";

  UserDeletedDomainEvent._(this._aggregateId, this._eventId, this._occuredAt, this._user);

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

  static UserDeletedDomainEvent fromUser(User user) {
    String uuid = const Uuid().v4();
    UuidValue eventId = UuidValue.fromString(uuid);
    DateTime occuredAt = DateTime.now();
    return UserDeletedDomainEvent._(user.id().value(), eventId, occuredAt, user);
  }

  Map<String, dynamic> toJson() {
    return {
      'eventName': _eventName,
      'aggregateId': _aggregateId.toString(),
      'eventId': _eventId.toString(),
      'occuredAt': _occuredAt.toString(),
      'user': _user.toJson()
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  User user() {
    return _user;
  }
}