import 'dart:convert';
import 'package:overload/domain/shared/domain_event_interface.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:uuid/uuid.dart';

class WorkoutDeletedDomainEvent implements DomainEventInterface {
  final UuidValue _aggregateId;
  final UuidValue _eventId;
  final DateTime _occuredAt;
  final Workout _workout;
  static const String _eventName = "WorkoutDeletedDomainEvent";

  WorkoutDeletedDomainEvent._(
    this._aggregateId,
    this._eventId,
    this._occuredAt,
    this._workout,
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

  static WorkoutDeletedDomainEvent fromWorkout(Workout workout) {
    String uuid = const Uuid().v4();
    UuidValue eventId = UuidValue.fromString(uuid);
    DateTime occuredAt = DateTime.now();
    return WorkoutDeletedDomainEvent._(
      workout.id().value(),
      eventId,
      occuredAt,
      workout,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventName': _eventName,
      'aggregateId': _aggregateId.toString(),
      'eventId': _eventId.toString(),
      'occuredAt': _occuredAt.toString(),
      'workout': _workout.toJson()
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }

  Workout workout() {
    return _workout;
  }
}
