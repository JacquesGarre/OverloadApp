import 'dart:convert';

import 'package:overload/domain/shared/domain_event_collection.dart';
import 'package:overload/domain/user/age.dart';
import 'package:overload/domain/user/domain_events/user_created_domain_event.dart';
import 'package:overload/domain/user/domain_events/user_deleted_domain_event.dart';
import 'package:overload/domain/user/domain_events/user_updated_domain_event.dart';
import 'package:overload/domain/user/equipment.dart';
import 'package:overload/domain/user/fitness_goals.dart';
import 'package:overload/domain/user/fitness_level.dart';
import 'package:overload/domain/user/gender.dart';
import 'package:overload/domain/user/id.dart';
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

  User update({
    WorkoutDurationPreference? newWorkoutDurationPreference,
    FitnessGoals? newFitnessGoals,
    WorkoutWeeklyDays? newWorkoutWeeklyDays,
    FitnessLevel? newFitnessLevel,
    TrainingTypes? newTrainingTypes,
    TrainingLocations? newTrainingLocations,
    Equipment? newEquipment,
  }) {
    User user = User._(
      domainEvents: domainEvents(),
      id: id(),
      username: username(),
      age: age(),
      weight: weight(),
      gender: gender(),
      workoutDurationPreference:
          newWorkoutDurationPreference ?? workoutDurationPreference(),
      fitnessGoals: newFitnessGoals ?? fitnessGoals(),
      workoutWeeklyDays: newWorkoutWeeklyDays ?? workoutWeeklyDays(),
      fitnessLevel: newFitnessLevel ?? fitnessLevel(),
      trainingTypes: newTrainingTypes ?? trainingTypes(),
      trainingLocations: newTrainingLocations ?? trainingLocations(),
      equipment: newEquipment ?? equipment(),
    );
    user.domainEvents().publish(UserUpdatedDomainEvent.fromUser(user));
    return user;
  }

  void delete() {
    domainEvents().publish(UserDeletedDomainEvent.fromUser(this));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id.toString(),
      'username': _username.value(),
      'age': _age.value(),
      'weight': _weight.value(),
      'gender': _gender.value(),
      'training_types': _trainingTypes != null
          ? jsonEncode(_trainingTypes.toStringList())
          : null,
      'workout_duration_preference': _workoutDurationPreference?.value(),
      'training_locations': _trainingLocations != null
          ? jsonEncode(_trainingLocations.toStringList())
          : null,
      'fitness_level': _fitnessLevel?.toString(),
      'fitness_goals': _fitnessGoals != null
          ? jsonEncode(_fitnessGoals.toStringList())
          : null,
      'equipment':
          _equipment != null ? jsonEncode(_equipment.toStringList()) : null,
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
    WorkoutDurationPreference? workoutDurationPreference;
    if (json['workout_duration_preference'] != null) {
      workoutDurationPreference = WorkoutDurationPreference(
        value: int.parse(json['workout_duration_preference']),
      );
    }
    WorkoutWeeklyDays? workoutWeeklyDays;
    if (json['workout_weekly_days'] != null) {
      workoutWeeklyDays = WorkoutWeeklyDays.fromInt(
        int.parse(json['workout_weekly_days']),
      );
    }
    FitnessGoals? fitnessGoals;
    if (json['fitness_goals'] != null) {
      fitnessGoals = FitnessGoals.fromStringList(
        List<String>.from(jsonDecode(json['fitness_goals'] as String)),
      );
    }
    TrainingTypes? trainingTypes;
    if (json['training_types'] != null) {
      trainingTypes = TrainingTypes.fromStringList(
        List<String>.from(jsonDecode(json['training_types'] as String)),
      );
    }
    TrainingLocations? trainingLocations;
    if (json['training_locations'] != null) {
      trainingLocations = TrainingLocations.fromStringList(
        List<String>.from(jsonDecode(json['training_locations'] as String)),
      );
    }
    Equipment? equipment;
    if (json['equipment'] != null) {
      equipment = Equipment.fromStringList(
        List<String>.from(jsonDecode(json['equipment'] as String)),
      );
    }
    FitnessLevel? fitnessLevel;
    if (json['fitness_level'] != null) {
      fitnessLevel = FitnessLevel.fromString(json['fitness_level'] as String);
    }
    return User._(
      domainEvents: domainEvents,
      id: id,
      username: username,
      age: age,
      gender: gender,
      weight: weight,
      workoutDurationPreference: workoutDurationPreference,
      workoutWeeklyDays: workoutWeeklyDays,
      fitnessGoals: fitnessGoals,
      trainingTypes: trainingTypes,
      trainingLocations: trainingLocations,
      equipment: equipment,
      fitnessLevel: fitnessLevel,
    );
  }

  bool isProfileCompleted() {
    return _trainingTypes != null &&
        _workoutDurationPreference != null &&
        _trainingLocations != null &&
        _fitnessLevel != null &&
        _fitnessGoals != null &&
        _equipment != null &&
        _workoutWeeklyDays != null;
  }
}
