import 'package:overload/application/workout/generate_workouts_command/generate_workouts_command.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/exercise_repository_interface.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/user/exception/user_not_found_exception.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/domain/user/user_repository_interface.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_generator_interface.dart';
import 'package:overload/domain/workout/workout_repository_interface.dart';

class GenerateWorkoutsCommandHandler {
  final UserRepositoryInterface userRepository;
  final WorkoutGeneratorInterface workoutGenerator;
  final ExerciseRepositoryInterface exerciseRepository;
  final WorkoutRepositoryInterface workoutRepository;
  final DomainEventBusInterface domainEventBus;

  GenerateWorkoutsCommandHandler({
    required this.userRepository,
    required this.workoutGenerator,
    required this.exerciseRepository,
    required this.workoutRepository,
    required this.domainEventBus,
  });

  Future<void> invoke(GenerateWorkoutsCommand command) async {
    User? user = await userRepository.findCurrentUser();
    if (user == null) {
      throw UserNotFoundException();
    }
    List<Workout> workouts = await workoutGenerator.generateFromUser(user);
    for (Workout workout in workouts) {
      for (WorkoutExercise workoutExercise in workout.exercises().value()) {
        Exercise exercise = workoutExercise.exercise();
        Exercise? existingExercise = await exerciseRepository.ofId(
          exercise.id(),
        );
        if (existingExercise != null) {
          continue;
        }
        await exerciseRepository.add(exercise);
      }
      Workout? existingWorkout = await workoutRepository.ofId(workout.id());
      if (existingWorkout != null) {
        continue;
      }
      await workoutRepository.add(workout);
      domainEventBus.publish(workout.domainEvents());
    }
    User updatedUser = user.completeProfile();
    await userRepository.update(updatedUser);
    domainEventBus.publish(updatedUser.domainEvents());
  }
}
