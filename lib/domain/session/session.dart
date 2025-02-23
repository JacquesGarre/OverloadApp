import 'dart:convert';

import 'package:overload/domain/session/domain_events/session_deleted_domain_event.dart';
import 'package:overload/domain/session/domain_events/session_exercise_added_domain_event.dart';
import 'package:overload/domain/session/domain_events/session_exercise_removed_domain_event.dart';
import 'package:overload/domain/session/domain_events/session_finished_domain_event.dart';
import 'package:overload/domain/session/domain_events/session_started_domain_event.dart';
import 'package:overload/domain/session/domain_events/session_exercise_updated_domain_event.dart';
import 'package:overload/domain/session/domain_events/session_updated_domain_event.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/workout/id.dart' as workout_id;
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/domain/session/session_exercises.dart';
import 'package:overload/domain/shared/domain_event_collection.dart';
import 'package:overload/domain/shared/notes.dart';
import 'package:overload/domain/user/weight.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';

class Session {
  final DomainEventsCollection _domainEvents;
  final Id _id;
  final workout_id.Id _workoutId;
  final Workout _workout;
  final DateTime _startDate;
  final DateTime? _endDate;
  final SessionExercises _exercises;
  final Notes? _notes;
  final Session? _previousSession;

  Session._({
    required DomainEventsCollection domainEvents,
    required Id id,
    required workout_id.Id workoutId,
    required Workout workout,
    required DateTime startDate,
    required SessionExercises exercises,
    DateTime? endDate,
    Notes? notes,
    Session? previousSession,
  })  : _domainEvents = domainEvents,
        _id = id,
        _workoutId = workoutId,
        _workout = workout,
        _startDate = startDate,
        _endDate = endDate,
        _exercises = exercises,
        _notes = notes,
        _previousSession = previousSession;

  DomainEventsCollection domainEvents() {
    return _domainEvents;
  }

  Id id() {
    return _id;
  }

  workout_id.Id workoutId() {
    return _workoutId;
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

  Notes? notes() {
    return _notes;
  }

  Session setPreviousSession(Session previousSession) {
    Session updatedSession = Session._(
      domainEvents: DomainEventsCollection(),
      id: id(),
      workoutId: workoutId(),
      workout: workout(),
      startDate: startDate(),
      endDate: endDate(),
      exercises: sessionExercises(),
      notes: notes(),
      previousSession: previousSession,
    );
    return updatedSession;
  }

  Session? previousSession() {
    return _previousSession;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id.toString(),
      "workout_id": _workoutId.toString(),
      "workout": jsonEncode(_workout.toJson()),
      "start_date": _startDate.toString(),
      "end_date": _endDate?.toString(),
      "exercises": jsonEncode(_exercises.toJson()),
      "notes": _notes?.value().toString()
    };
  }

  static Session fromJson(Map<String, dynamic> json) {
    Id id = Id.fromString(json["id"]);
    workout_id.Id workoutId = workout_id.Id.fromString(json["workout_id"]);
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
    Notes? notes = Notes.fromString(json["notes"]);
    return Session._(
      domainEvents: DomainEventsCollection(),
      id: id,
      workoutId: workoutId,
      workout: workout,
      startDate: startDate,
      endDate: endDate,
      exercises: exercises,
      notes: notes,
    );
  }

  static Session startFromWorkout(Workout workout) {
    Session session = Session._(
      domainEvents: DomainEventsCollection(),
      id: Id.create(),
      workoutId: workout.id(),
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

  Session updateSessionExercise(SessionExercise exercise) {
    SessionExercises exercises = _exercises.update(exercise);
    Session updatedSession = Session._(
      domainEvents: DomainEventsCollection(),
      id: id(),
      workoutId: workoutId(),
      workout: workout(),
      startDate: startDate(),
      endDate: endDate(),
      exercises: exercises,
      notes: notes(),
      previousSession: previousSession(),
    );
    updatedSession.domainEvents().publish(
          SessionExerciseUpdatedDomainEvent.fromSessionAndSessionExercise(
            updatedSession,
            exercise,
          ),
        );
    return updatedSession;
  }

  Session addSessionExercise(SessionExercise exercise) {
    SessionExercises exercises = _exercises.add(exercise);
    Session updatedSession = Session._(
      domainEvents: DomainEventsCollection(),
      id: id(),
      workoutId: workoutId(),
      workout: workout(),
      startDate: startDate(),
      endDate: endDate(),
      exercises: exercises,
      notes: notes(),
      previousSession: previousSession(),
    );
    updatedSession.domainEvents().publish(
          SessionExerciseAddedDomainEvent.fromSessionAndSessionExercise(
            updatedSession,
            exercise,
          ),
        );
    return updatedSession;
  }

  Session removeSessionExercise(SessionExercise exercise) {
    SessionExercises exercises = _exercises.remove(exercise);
    Session updatedSession = Session._(
      domainEvents: DomainEventsCollection(),
      id: id(),
      workoutId: workoutId(),
      workout: workout(),
      startDate: startDate(),
      endDate: endDate(),
      exercises: exercises,
      notes: notes(),
      previousSession: previousSession(),
    );
    updatedSession.domainEvents().publish(
          SessionExerciseRemovedDomainEvent.fromSessionAndSessionExercise(
            updatedSession,
            exercise,
          ),
        );
    return updatedSession;
  }

  Session finish() {
    Session finishedSession = Session._(
      domainEvents: DomainEventsCollection(),
      id: id(),
      workoutId: workoutId(),
      workout: workout(),
      startDate: startDate(),
      exercises: sessionExercises(),
      endDate: DateTime.now(),
      notes: notes(),
      previousSession: previousSession(),
    );
    finishedSession.domainEvents().publish(
          SessionFinishedDomainEvent.fromSession(finishedSession),
        );
    return finishedSession;
  }

  int finishedSetsCount() {
    return _exercises.finishedSetsCount();
  }

  num finishedVolume(Weight userWeight) {
    return _exercises.finishedVolume(userWeight);
  }

  num finishedRepsCount() {
    return _exercises.finishedRepsCount();
  }

  Session update(Notes? newNotes) {
    Session updatedSession = Session._(
      domainEvents: DomainEventsCollection(),
      id: id(),
      workoutId: workoutId(),
      workout: workout(),
      startDate: startDate(),
      exercises: sessionExercises(),
      endDate: endDate(),
      notes: newNotes,
      previousSession: previousSession(),
    );
    updatedSession.domainEvents().publish(
          SessionUpdatedDomainEvent.fromSession(updatedSession),
        );
    return updatedSession;
  }

  SessionExercise? findSessionExercise(WorkoutExercise workoutExercise) {
    return _exercises.findSessionExercise(workoutExercise);
  }
}
