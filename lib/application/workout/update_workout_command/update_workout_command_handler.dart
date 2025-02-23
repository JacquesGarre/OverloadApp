import 'package:overload/application/workout/update_workout_command/update_workout_command.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/workout/exception/workout_already_exists_exception.dart';
import 'package:overload/domain/workout/exception/workout_exercise_required_exception.dart';
import 'package:overload/domain/workout/exception/workout_not_found_exception.dart';
import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/workout_repository_interface.dart';
import 'package:overload/domain/workout/name.dart';
import 'package:overload/domain/shared/notes.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercises.dart';

class UpdateWorkoutCommandHandler {
  final WorkoutRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  UpdateWorkoutCommandHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<void> invoke(UpdateWorkoutCommand command) async {
    Id id = Id.fromString(command.id);
    Workout? workout = await repository.ofId(id);
    if (workout == null) {
      throw WorkoutNotFoundException();
    }
    Name name = Name.fromString(command.name);
    WorkoutExercises workoutExercises = command.workoutExercises;
    if (workoutExercises.count() < 1) {
      throw WorkoutExerciseRequiredException();
    }
    Notes? notes = Notes.fromString(command.notes!);
    Workout updatedWorkout = workout.update(name, workoutExercises, notes);
    if (!name.equals(workout.name())) {
      Workout? existingWorkout = await repository.ofName(updatedWorkout.name());
      if (existingWorkout != null) {
        throw WorkoutAlreadyExistsException();
      }
    }
    await repository.update(updatedWorkout);
    domainEventBus.publish(updatedWorkout.domainEvents());
  }
}
