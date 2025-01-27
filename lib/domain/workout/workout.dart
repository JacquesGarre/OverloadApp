import 'dart:convert';

import 'package:overload/domain/shared/domain_event_collection.dart';
import 'package:overload/domain/workout/domain_events/workout_created_domain_event.dart';
import 'package:overload/domain/workout/domain_events/workout_deleted_domain_event.dart';
import 'package:overload/domain/workout/domain_events/workout_updated_domain_event.dart';
import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/name.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/workout_exercises.dart';

class Workout {
  final DomainEventsCollection _domainEvents;
  final Id _id;
  final Name _name;
  final WorkoutExercises _exercises;
  final Notes? _notes;

  Workout({
    required DomainEventsCollection domainEvents,
    required Id id,
    required Name name,
    required WorkoutExercises exercises,
    Notes? notes,
  })  : _domainEvents = domainEvents,
        _id = id,
        _name = name,
        _exercises = exercises,
        _notes = notes;

  DomainEventsCollection domainEvents() {
    return _domainEvents;
  }

  Id id() {
    return _id;
  }

  Name name() {
    return _name;
  }

  WorkoutExercises exercises() {
    return _exercises;
  }

  Notes? notes() {
    return _notes;
  }

  int exercisesCount() {
    return _exercises.count();
  }

  static Workout create(
    Name name,
    WorkoutExercises workoutExercises,
    Notes? notes,
  ) {
    Workout workout = Workout(
      domainEvents: DomainEventsCollection(),
      id: Id.create(),
      name: name,
      exercises: workoutExercises,
      notes: notes,
    );
    workout
        .domainEvents()
        .publish(WorkoutCreatedDomainEvent.fromWorkout(workout));
    return workout;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id.toString(),
      "name": _name.value().toString(),
      "workout_exercises": jsonEncode(_exercises.toJson()),
      "notes": _notes?.value().toString()
    };
  }

  static Workout fromJson(Map<String, dynamic> json) {
    Id id = Id.fromString(json["id"]);
    Name name = Name.fromString(json["name"]);
    WorkoutExercises workoutExercises = WorkoutExercises.fromJson(
      (jsonDecode(json["workout_exercises"]) as List)
          .map((item) => item as Map<String, dynamic>)
          .toList(),
    );
    Notes? notes;
    if (json["notes"] != null) {
      notes = Notes(value: json["notes"]);
    }
    return Workout(
      domainEvents: DomainEventsCollection(),
      id: id,
      name: name,
      exercises: workoutExercises,
      notes: notes,
    );
  }

  void delete() {
    domainEvents().publish(WorkoutDeletedDomainEvent.fromWorkout(this));
  }

  Workout update(Name name, WorkoutExercises workoutExercises, Notes? notes) {
    Workout workout = Workout(
      domainEvents: DomainEventsCollection(),
      id: id(),
      name: name,
      exercises: workoutExercises,
      notes: notes,
    );
    workout.domainEvents().publish(WorkoutUpdatedDomainEvent.fromWorkout(workout));
    return workout;
  }
}
