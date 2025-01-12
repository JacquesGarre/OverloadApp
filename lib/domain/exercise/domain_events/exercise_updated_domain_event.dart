import 'dart:convert';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/shared/domain_event_interface.dart';
import 'package:uuid/uuid.dart';

class ExerciseUpdatedDomainEvent implements DomainEventInterface {

  final UuidValue _aggregateId;
  final UuidValue _eventId;
  final DateTime _occuredAt;
  final Exercise exercise;
  static const String _eventName = "ExerciseUpdatedDomainEvent";

  ExerciseUpdatedDomainEvent._(this._aggregateId, this._eventId, this._occuredAt, this.exercise);

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

  static ExerciseUpdatedDomainEvent fromExercise(Exercise exercise) {
    String uuid = const Uuid().v4();
    UuidValue eventId = UuidValue.fromString(uuid);
    DateTime occuredAt = DateTime.now();
    return ExerciseUpdatedDomainEvent._(exercise.id.value, eventId, occuredAt, exercise);
  }

  Map<String, dynamic> toJson() {
    return {
      'eventName': _eventName,
      'aggregateId': _aggregateId.toString(),
      'eventId': _eventId.toString(),
      'occuredAt': _occuredAt.toString(),
      'exercise': {
        'id': exercise.id.toString(),
        'name': exercise.name.value,
        'units': exercise.units.toStringList()
      }
    };
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}