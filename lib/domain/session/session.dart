import 'dart:convert';

import 'package:overload/domain/session/domain_events/session_deleted_domain_event.dart';
import 'package:overload/domain/session/domain_events/session_started_domain_event.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session_exercises.dart';
import 'package:overload/domain/shared/domain_event_collection.dart';
import 'package:overload/domain/workout/workout.dart';

class Session {
  final DomainEventsCollection _domainEvents;
  final Id _id;
  final Workout _workout;
  final DateTime _startDate;
  final DateTime? _endDate;
  final SessionExercises _exercises;

  Session._({
    required DomainEventsCollection domainEvents,
    required Id id,
    required Workout workout,
    required DateTime startDate,
    required SessionExercises exercises,
    DateTime? endDate,
  })  : _domainEvents = domainEvents,
        _id = id,
        _workout = workout,
        _startDate = startDate,
        _endDate = endDate,
        _exercises = exercises;

  DomainEventsCollection domainEvents() {
    return _domainEvents;
  }

  Id id() {
    return _id;
  }

  Workout workout() {
    return _workout;
  }

  DateTime startDate() {
    return _startDate;
  }

  DateTime? endDate() {
    return _endDate;
  }

  SessionExercises sessionExercises() {
    return _exercises;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id.toString(),
      "workout": jsonEncode(_workout.toJson()),
      "start_date": _startDate.toString(),
      "end_date": _endDate?.toString(),
      "exercises": jsonEncode(_exercises.toJson())
    };
  }

  static Session fromJson(Map<String, dynamic> json) {
    Id id = Id.fromString(json["id"]);
    Workout workout = Workout.fromJson(
      jsonDecode(json["workout"]),
    );
    DateTime startDate = DateTime.parse(json["start_date"]);
    DateTime? endDate;
    if (json["end_date"] != null) {
      endDate = DateTime.parse(json["end_date"]);
    }
    SessionExercises exercises = SessionExercises.fromJson(
      (jsonDecode(json["exercises"]) as List)
          .map((item) => item as Map<String, dynamic>)
          .toList(),
    );
    return Session._(
      domainEvents: DomainEventsCollection(),
      id: id,
      workout: workout,
      startDate: startDate,
      endDate: endDate,
      exercises: exercises,
    );
  }

  static Session startFromWorkout(Workout workout) {
    Session session = Session._(
      domainEvents: DomainEventsCollection(),
      id: Id.create(),
      workout: workout,
      startDate: DateTime.now(),
      exercises: SessionExercises.fromWorkoutExercises(workout.exercises()),
    );
    session
        .domainEvents()
        .publish(SessionStartedDomainEvent.fromSession(session));
    return session;
  }

  bool inProgress() {
    return _endDate == null;
  }

  void delete() {
    domainEvents().publish(SessionDeletedDomainEvent.fromSession(this));
  }
}
