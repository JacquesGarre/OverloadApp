import 'package:overload/application/exercise/add_exercise_command/add_exercise_command.dart';
import 'package:overload/application/session/start_session_command/start_session_command.dart';
import 'package:overload/domain/exercise/exception/exercise_already_exists_exception.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/exercise_repository_interface.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_repository_interface.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/workout/exception/workout_not_found_exception.dart';
import 'package:overload/domain/workout/id.dart' as workout_domain;
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_repository_interface.dart';

class StartSessionCommandHandler {

  final SessionRepositoryInterface sessionRepository;
  final WorkoutRepositoryInterface workoutRepository;
  final DomainEventBusInterface domainEventBus;

  StartSessionCommandHandler({required this.sessionRepository, required this.workoutRepository, required this.domainEventBus});

  Future<Session> invoke(StartSessionCommand command) async {
    workout_domain.Id workoutId = workout_domain.Id.fromString(command.workoutId);
    Workout? workout = await workoutRepository.ofId(workoutId);
    if (workout == null) {
      throw WorkoutNotFoundException();
    }
    Session session = Session.startFromWorkout(workout);
    await sessionRepository.add(session);
    domainEventBus.publish(session.domainEvents());
    return session;
  }
}
