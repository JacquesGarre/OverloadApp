import 'package:overload/domain/exercise/domain_events/exercise_created_domain_event.dart';
import 'package:overload/domain/exercise/domain_events/exercise_deleted_domain_event.dart';
import 'package:overload/domain/exercise/domain_events/exercise_updated_domain_event.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/domain/shared/domain_event_collection.dart';

class Exercise {

  final DomainEventsCollection domainEvents;
  final Id id;
  final Name name;
  final Units units;

  Exercise({
    required this.domainEvents,
    required this.id,
    required this.name,
    required this.units,
  });

  static Exercise create(Name name, Units units) {
    Exercise exercise = Exercise(
      domainEvents: DomainEventsCollection(),
      id: Id.create(),
      name: name,
      units: units,
    );
    exercise.domainEvents.publish(ExerciseCreatedDomainEvent.fromExercise(exercise));
    return exercise;
  }

  Exercise update(Name newName, Units newUnits) {
    Exercise exercise = Exercise(
      domainEvents: domainEvents,
      id: id,
      name: newName,
      units: newUnits,
    );
    exercise.domainEvents.publish(ExerciseUpdatedDomainEvent.fromExercise(exercise));
    return exercise;
  }

  delete() {
    domainEvents.publish(ExerciseDeletedDomainEvent.fromExercise(this));
  }
}
