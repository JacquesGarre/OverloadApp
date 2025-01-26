import 'package:overload/application/workout/get_workouts_query/get_workouts_query.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_repository_interface.dart';

class GetWorkoutsQueryHandler {
  final WorkoutRepositoryInterface repository;
  final DomainEventBusInterface domainEventBus;

  GetWorkoutsQueryHandler({
    required this.repository,
    required this.domainEventBus,
  });

  Future<List<Workout>> invoke(GetWorkoutsQuery query) async {
    List<Workout> workouts = await repository.findAll();
    return workouts;
  }
}
