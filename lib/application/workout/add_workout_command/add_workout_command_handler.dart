import 'package:overload/application/workout/add_workout_command/add_workout_command.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/workout/exception/workout_already_exists_exception.dart';
import 'package:overload/domain/workout/exception/workout_exercise_required_exception.dart';
import 'package:overload/domain/workout/workout_repository_interface.dart';
import 'package:overload/domain/workout/name.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercises.dart';

class AddWorkoutCommandHandler {
  final WorkoutRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  AddWorkoutCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<void> invoke(AddWorkoutCommand command) async {
    Name name = Name.fromString(command.name);
    WorkoutExercises workoutExercises = command.workoutExercises;
    if (workoutExercises.count() < 1) {
      throw WorkoutExerciseRequiredException();
    }
    Notes? notes;
    if (command.notes != null) {
      notes = Notes(value: command.notes!);
    }
    Workout workout = Workout.create(name, workoutExercises, notes);
    Workout? existingWorkout = await repository.ofId(workout.id());
    if (existingWorkout != null) {
      throw WorkoutAlreadyExistsException();
    }
    existingWorkout = await repository.ofName(workout.name());
    if (existingWorkout != null) {
      throw WorkoutAlreadyExistsException();
    }
    await repository.add(workout);
    domainEventBus.publish(workout.domainEvents());
  }
}
