import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command_handler.dart';
import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command_handler.dart';
import 'package:overload/application/exercise/get_exercises_query/get_exercises_query_handler.dart';
import 'package:overload/application/exercise/update_exercise_command/update_exercise_command_handler.dart';
import 'package:overload/domain/exercise/interface/exercise_repository_interface.dart';
import 'package:overload/domain/shared/domain_event_bus_interface.dart';
import 'package:overload/infrastructure/bus/domain_event_bus.dart';
import 'package:overload/infrastructure/persistence/database.dart';
import 'package:overload/infrastructure/persistence/repositories/exercise_repository.dart';
import 'package:overload/infrastructure/providers/exercise/exercise_provider.dart';
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
}
