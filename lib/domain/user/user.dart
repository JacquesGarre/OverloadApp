import 'dart:convert';

import 'package:overload/domain/shared/domain_event_collection.dart';
import 'package:overload/domain/user/age.dart';
import 'package:overload/domain/user/domain_events/user_created_domain_event.dart';
import 'package:overload/domain/user/domain_events/user_deleted_domain_event.dart';
import 'package:overload/domain/user/equipment.dart';
import 'package:overload/domain/user/fitness_goals.dart';
import 'package:overload/domain/user/fitness_level.dart';
import 'package:overload/domain/user/gender.dart';
import 'package:overload/domain/user/id.dart';
import 'package:overload/domain/user/motivation_preference.dart';
import 'package:overload/domain/user/training_locations.dart';
import 'package:overload/domain/user/training_types.dart';
import 'package:overload/domain/user/username.dart';
import 'package:overload/domain/user/weight.dart';
import 'package:overload/domain/user/workout_duration_preference.dart';
import 'package:overload/domain/user/workout_weekly_days.dart';

class User {
  final DomainEventsCollection _domainEvents;
  final Id _id;
  final Username _username;
  final Age _age;
  final Gender _gender;
  final Weight _weight;
  final TrainingTypes? _trainingTypes;
  final WorkoutDurationPreference? _workoutDurationPreference;
  final TrainingLocations? _trainingLocations;
  final MotivationPreference? _motivationPreference;
  final FitnessLevel? _fitnessLevel;
  final FitnessGoals? _fitnessGoals;
  final Equipment? _equipment;
  final WorkoutWeeklyDays? _workoutWeeklyDays;

  User._({
    required DomainEventsCollection domainEvents,
    required Id id,
    required Username username,
    required Age age,
    required Gender gender,
    required Weight weight,
    TrainingTypes? trainingTypes,
    WorkoutDurationPreference? workoutDurationPreference,
    TrainingLocations? trainingLocations,
    MotivationPreference? motivationPreference,
    FitnessLevel? fitnessLevel,
    FitnessGoals? fitnessGoals,
    Equipment? equipment,
    WorkoutWeeklyDays? workoutWeeklyDays,
  })  : _domainEvents = domainEvents,
        _id = id,
        _username = username,
        _age = age,
        _gender = gender,
        _weight = weight,
        _trainingTypes = trainingTypes,
        _workoutDurationPreference = workoutDurationPreference,
        _trainingLocations = trainingLocations,
        _motivationPreference = motivationPreference,
        _fitnessLevel = fitnessLevel,
        _fitnessGoals = fitnessGoals,
        _equipment = equipment,
        _workoutWeeklyDays = workoutWeeklyDays;

  DomainEventsCollection domainEvents() {
    return _domainEvents;
  }

  Id id() {
    return _id;
  }

  Username username() {
    return _username;
  }

  Age age() {
    return _age;
  }

  Gender gender() {
    return _gender;
  }

  Weight weight() {
    return _weight;
  }

  TrainingTypes? trainingTypes() {
    return _trainingTypes;
  }

  WorkoutDurationPreference? workoutDurationPreference() {
    return _workoutDurationPreference;
  }

  TrainingLocations? trainingLocations() {
    return _trainingLocations;
  }

  MotivationPreference? motivationPreference() {
    return _motivationPreference;
  }

  FitnessLevel? fitnessLevel() {
    return _fitnessLevel;
  }

  FitnessGoals? fitnessGoals() {
    return _fitnessGoals;
  }

  Equipment? equipment() {
    return _equipment;
  }

  WorkoutWeeklyDays? workoutWeeklyDays() {
    return _workoutWeeklyDays;
  }

  static User create(
    Username username,
    Age age,
    Weight weight,
    Gender gender,
  ) {
    DomainEventsCollection domainEvents = DomainEventsCollection();
    Id id = Id.create();
    User user = User._(
      domainEvents: domainEvents,
      id: id,
      username: username,
      age: age,
      weight: weight,
      gender: gender,
    );
    user.domainEvents().publish(UserCreatedDomainEvent.fromUser(user));
    return user;
  }

  void delete() {
    domainEvents().publish(UserDeletedDomainEvent.fromUser(this));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id.toString(), // OK in form
      'username': _username.value(), // OK in form
      'age': _age.value(), // OK in form
      'weight': _weight.value(), // OK in form
      'gender': _gender.value(), // OK in form
      'training_types': jsonEncode(_trainingTypes?.toStringList()),
      'workout_duration_preference': _workoutDurationPreference?.toString(),
      'training_locations': jsonEncode(_trainingLocations?.toStringList()),
      'motivation_preferences': _motivationPreference?.toString(),
      'fitness_level': _fitnessLevel?.toString(),
      'fitness_goals': jsonEncode(_fitnessGoals?.toStringList()), // OK in form
      'equipment': jsonEncode(_equipment?.toStringList()),
      'workout_weekly_days': _workoutWeeklyDays?.value()
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    DomainEventsCollection domainEvents = DomainEventsCollection();
    Id id = Id.fromString(json['id'] as String);
    Username username = Username.fromString(json['username'] as String);
    Age age = Age.fromString(json['age'] as String);
    Weight weight = Weight.fromString(json['weight'] as String);
    Gender gender = Gender.fromString(json['gender'] as String);
    // TODO: Other properties
    return User._(
      domainEvents: domainEvents,
      id: id,
      username: username,
      age: age,
      gender: gender,
      weight: weight,
    );
  }
}
