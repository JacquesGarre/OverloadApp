import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command_handler.dart';
import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command_handler.dart';
import 'package:overload/application/exercise/get_exercises_query/get_exercises_query_handler.dart';
import 'package:overload/application/exercise/update_exercise_command/update_exercise_command_handler.dart';
import 'package:overload/application/session/add_session_exercise_command/add_session_exercise_command_handler.dart';
import 'package:overload/application/session/delete_session_command/delete_session_command_handler.dart';
import 'package:overload/application/session/finish_session_command/finish_session_command_handler.dart';
import 'package:overload/application/session/get_current_session_query/get_current_session_query_handler.dart';
import 'package:overload/application/session/get_session_query/get_session_query_handler.dart';
import 'package:overload/application/session/get_sessions_query/get_sessions_query_handler.dart';
import 'package:overload/application/session/remove_session_exercise_command/remove_session_exercise_command_handler.dart';
import 'package:overload/application/session/start_session_command/start_session_command_handler.dart';
import 'package:overload/application/session/update_session_command/update_session_command_handler.dart';
import 'package:overload/application/session/update_session_exercise_command/update_session_exercise_command_handler.dart';
import 'package:overload/application/user/create_user_command/create_user_command_handler.dart';
import 'package:overload/application/user/delete_user_command/delete_user_command_handler.dart';
import 'package:overload/application/user/get_user_query/get_user_query_handler.dart';
import 'package:overload/application/user/update_user_command/update_user_command_handler.dart';
import 'package:overload/application/workout/add_workout_command/add_workout_command_handler.dart';
import 'package:overload/application/workout/delete_workout_command/delete_workout_command_handler.dart';
import 'package:overload/application/workout/get_workouts_query/get_workouts_query_handler.dart';
import 'package:overload/application/workout/update_workout_command/update_workout_command_handler.dart';
import 'package:overload/domain/exercise/exercise_repository_interface.dart';
import 'package:overload/domain/session/session_repository_interface.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/domain/user/user_repository_interface.dart';
import 'package:overload/domain/workout/workout_repository_interface.dart';
import 'package:overload/infrastructure/bus/domain_event_bus.dart';
import 'package:overload/infrastructure/persistence/database.dart';
import 'package:overload/infrastructure/persistence/repositories/exercise_repository.dart';
import 'package:overload/infrastructure/persistence/repositories/session_repository.dart';
import 'package:overload/infrastructure/persistence/repositories/user_repository.dart';
import 'package:overload/infrastructure/persistence/repositories/workout_repository.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/providers/user_provider.dart';
import 'package:overload/infrastructure/providers/workout_provider.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

GetIt container = GetIt.instance;

Future<void> setupContainer() async {
  await registerDatabases();
  await registerRepositories();
  await registerBuses();
  await registerHandlers();
  await registerProviders();
}

Future<void> registerDatabases() async {
  sqflite.Database database = await Database.getDatabase();
  container.registerSingleton<sqflite.Database>(database);
}

Future<void> registerRepositories() async {
  container.registerFactory<ExerciseRepositoryInterface>(
    () => ExerciseRepository(
      db: container<sqflite.Database>(),
    ),
  );
  container.registerFactory<WorkoutRepositoryInterface>(
    () => WorkoutRepository(
      db: container<sqflite.Database>(),
    ),
  );
  container.registerFactory<SessionRepositoryInterface>(
    () => SessionRepository(
      db: container<sqflite.Database>(),
    ),
  );
  container.registerFactory<UserRepositoryInterface>(
    () => UserRepository(
      db: container<sqflite.Database>(),
    ),
  );
}

Future<void> registerBuses() async {
  container.registerSingleton<EventBus>(EventBus());
  container.registerFactory<DomainEventBusInterface>(
    () => DomainEventBus(
      eventBus: container<EventBus>(),
    ),
  );
}

Future<void> registerHandlers() async {
  container.registerFactory<GetExercisesQueryHandler>(
    () => GetExercisesQueryHandler(
      repository: container<ExerciseRepositoryInterface>(),
    ),
  );
  container.registerFactory<AddExerciseCommandHandler>(
    () => AddExerciseCommandHandler(
      repository: container<ExerciseRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<DeleteExerciseCommandHandler>(
    () => DeleteExerciseCommandHandler(
      repository: container<ExerciseRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<UpdateExerciseCommandHandler>(
    () => UpdateExerciseCommandHandler(
      repository: container<ExerciseRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<AddWorkoutCommandHandler>(
    () => AddWorkoutCommandHandler(
      repository: container<WorkoutRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<GetWorkoutsQueryHandler>(
    () => GetWorkoutsQueryHandler(
      repository: container<WorkoutRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<DeleteWorkoutCommandHandler>(
    () => DeleteWorkoutCommandHandler(
      repository: container<WorkoutRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<UpdateWorkoutCommandHandler>(
    () => UpdateWorkoutCommandHandler(
      repository: container<WorkoutRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<StartSessionCommandHandler>(
    () => StartSessionCommandHandler(
      sessionRepository: container<SessionRepositoryInterface>(),
      workoutRepository: container<WorkoutRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<DeleteSessionCommandHandler>(
    () => DeleteSessionCommandHandler(
      sessionRepository: container<SessionRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<GetSessionsQueryHandler>(
    () => GetSessionsQueryHandler(
      repository: container<SessionRepositoryInterface>(),
    ),
  );
  container.registerFactory<GetCurrentSessionQueryHandler>(
    () => GetCurrentSessionQueryHandler(
      repository: container<SessionRepositoryInterface>(),
    ),
  );
  container.registerFactory<UpdateSessionExerciseCommandHandler>(
    () => UpdateSessionExerciseCommandHandler(
      repository: container<SessionRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<AddSessionExerciseCommandHandler>(
    () => AddSessionExerciseCommandHandler(
      repository: container<SessionRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<RemoveSessionExerciseCommandHandler>(
    () => RemoveSessionExerciseCommandHandler(
      repository: container<SessionRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<FinishSessionCommandHandler>(
    () => FinishSessionCommandHandler(
      repository: container<SessionRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<UpdateSessionCommandHandler>(
    () => UpdateSessionCommandHandler(
      repository: container<SessionRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<GetSessionQueryHandler>(
    () => GetSessionQueryHandler(
      repository: container<SessionRepositoryInterface>(),
    ),
  );
  container.registerFactory<CreateUserCommandHandler>(
    () => CreateUserCommandHandler(
      repository: container<UserRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<DeleteUserCommandHandler>(
    () => DeleteUserCommandHandler(
      repository: container<UserRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<UpdateUserCommandHandler>(
    () => UpdateUserCommandHandler(
      repository: container<UserRepositoryInterface>(),
      domainEventBus: container<DomainEventBusInterface>(),
    ),
  );
  container.registerFactory<GetUserQueryHandler>(
    () => GetUserQueryHandler(
      repository: container<UserRepositoryInterface>(),
    ),
  );
}

Future<void> registerProviders() async {
  container.registerSingleton<ExerciseProvider>(
    ExerciseProvider(
      getExercisesQueryHandler: container<GetExercisesQueryHandler>(),
      addExerciseCommandHandler: container<AddExerciseCommandHandler>(),
      deleteExerciseCommandHandler: container<DeleteExerciseCommandHandler>(),
      updateExerciseCommandHandler: container<UpdateExerciseCommandHandler>(),
    ),
  );
  container.registerSingleton<WorkoutProvider>(
    WorkoutProvider(
      addWorkoutCommandHandler: container<AddWorkoutCommandHandler>(),
      getWorkoutsQueryHandler: container<GetWorkoutsQueryHandler>(),
      deleteWorkoutCommandHandler: container<DeleteWorkoutCommandHandler>(),
      updateWorkoutCommandHandler: container<UpdateWorkoutCommandHandler>(),
    ),
  );
  container.registerSingleton<SessionProvider>(
    SessionProvider(
      startSessionCommandHandler: container<StartSessionCommandHandler>(),
      getSessionsQueryHandler: container<GetSessionsQueryHandler>(),
      getCurrentSessionQueryHandler: container<GetCurrentSessionQueryHandler>(),
      deleteSessionCommandHandler: container<DeleteSessionCommandHandler>(),
      updateSessionExerciseCommandHandler:
          container<UpdateSessionExerciseCommandHandler>(),
      removeSessionExerciseCommandHandler:
          container<RemoveSessionExerciseCommandHandler>(),
      getSessionQueryHandler: container<GetSessionQueryHandler>(),
      addSessionExerciseCommandHandler:
          container<AddSessionExerciseCommandHandler>(),
      finishSessionCommandHandler: container<FinishSessionCommandHandler>(),
      updateSessionCommandHandler: container<UpdateSessionCommandHandler>(),
    ),
  );
  container.registerSingleton<UserProvider>(UserProvider(
    createUserCommandHandler: container<CreateUserCommandHandler>(),
    deleteUserCommandHandler: container<DeleteUserCommandHandler>(),
    updateUserCommandHandler: container<UpdateUserCommandHandler>(),
    getUserQueryHandler: container<GetUserQueryHandler>(),
  ));
}
