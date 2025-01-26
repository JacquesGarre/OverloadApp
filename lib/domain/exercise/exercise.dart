import 'dart:convert';

import 'package:overload/domain/exercise/domain_events/exercise_created_domain_event.dart';
import 'package:overload/domain/exercise/domain_events/exercise_deleted_domain_event.dart';
import 'package:overload/domain/exercise/domain_events/exercise_updated_domain_event.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/domain/shared/domain_event_collection.dart';

class Exercise {
  final DomainEventsCollection _domainEvents;
  final Id _id;
  final Name _name;
  final Units _units;

  Exercise({
    required DomainEventsCollection domainEvents,
    required Id id,
    required Name name,
    required Units units,
  })  : _domainEvents = domainEvents,
        _id = id,
        _name = name,
        _units = units;

  DomainEventsCollection domainEvents() {
    return _domainEvents;
  }

  Id id() {
    return _id;
  }

  Name name() {
    return _name;
  }

  Units units() {
    return _units;
  }

  static Exercise create(Name name, Units units) {
    Exercise exercise = Exercise(
      domainEvents: DomainEventsCollection(),
      id: Id.create(),
      name: name,
      units: units,
    );
    exercise
        .domainEvents()
        .publish(ExerciseCreatedDomainEvent.fromExercise(exercise));
    return exercise;
  }

  Exercise update(Name newName, Units newUnits) {
    Exercise exercise = Exercise(
      domainEvents: domainEvents(),
      id: id(),
      name: newName,
      units: newUnits,
    );
    exercise
        .domainEvents()
        .publish(ExerciseUpdatedDomainEvent.fromExercise(exercise));
    return exercise;
  }

  delete() {
    domainEvents().publish(ExerciseDeletedDomainEvent.fromExercise(this));
  }

  @override
  String toString() {
    return name().value();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'units': jsonEncode(units),
    };
  }

  static Exercise fromJson(Map<String, dynamic> json) {
    Id id = Id.fromString(json['id'] as String);
    Name name = Name.fromString(json['name'] as String);
    Units units = Units.fromStringList(
      List<String>.from(jsonDecode(json['units'] as String)),
    );
    return Exercise(
      domainEvents: DomainEventsCollection(),
      id: id,
      name: name,
      units: units,
    );
  }
}
