import 'package:overload/domain/shared/domain_event_collection.dart';
import 'package:overload/domain/user/age.dart';
import 'package:overload/domain/user/equipment.dart';
import 'package:overload/domain/user/fitness_goals.dart';
import 'package:overload/domain/user/fitness_level.dart';
import 'package:overload/domain/user/gender.dart';
import 'package:overload/domain/user/id.dart';
import 'package:overload/domain/user/motivation_preferences.dart';
import 'package:overload/domain/user/training_locations.dart';
import 'package:overload/domain/user/training_types.dart';
import 'package:overload/domain/user/username.dart';
import 'package:overload/domain/user/weight.dart';
import 'package:overload/domain/user/workout_duration_preference.dart';

class User {

  final DomainEventsCollection _domainEvents;
  final Id _id;
  final Username _username;
  final Age _age;
  final Gender _gender;
  final Weight _weight;
  final TrainingTypes _trainingTypes;
  final WorkoutDurationPreference _workoutDurationPreference;
  final TrainingLocations _trainingLocations;
  final MotivationPreferences _motivationPreferences;
  final FitnessLevel _fitnessLevel;
  final FitnessGoals _fitnessGoals;
  final Equipment _equipment;

  User({
    required DomainEventsCollection domainEvents,
    required Id id,
    required Username username,
    required Age age,
    required Gender gender,
    required Weight weight,
    required TrainingTypes trainingTypes,
    required WorkoutDurationPreference workoutDurationPreference,
    required TrainingLocations trainingLocations,
    required MotivationPreferences motivationPreferences,
    required FitnessLevel fitnessLevel,
    required FitnessGoals fitnessGoals,
    required Equipment equipment,
  })  : _domainEvents = domainEvents,
        _id = id,
        _username = username,
        _age = age,
        _gender = gender,
        _weight = weight,
        _trainingTypes = trainingTypes,
        _workoutDurationPreference = workoutDurationPreference,
        _trainingLocations = trainingLocations,
        _motivationPreferences = motivationPreferences,
        _fitnessLevel = fitnessLevel,
        _fitnessGoals = fitnessGoals,
        _equipment = equipment;

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

  TrainingTypes trainingTypes() {
    return _trainingTypes;
  }

  WorkoutDurationPreference workoutDurationPreference() {
    return _workoutDurationPreference;
  }

  TrainingLocations trainingLocations() {
    return _trainingLocations;
  }

  MotivationPreferences motivationPreferences() {
    return _motivationPreferences;
  }

  FitnessLevel fitnessLevel() {
    return _fitnessLevel;
  }

  FitnessGoals fitnessGoals() {
    return _fitnessGoals;
  }

  Equipment equipment() {
    return _equipment;
  }

}
