import 'package:get_it/get_it.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command_handler.dart';
import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command_handler.dart';
import 'package:overload/application/exercise/get_exercises_query/get_exercises_query_handler.dart';
import 'package:overload/application/exercise/update_exercise_command/update_exercise_command_handler.dart';
import 'package:overload/domain/exercise/exercise_repository_interface.dart';
import 'package:overload/infrastructure/persistence/database.dart';
import 'package:overload/infrastructure/persistence/repositories/exercise_repository.dart';
import 'package:overload/infrastructure/providers/exercise/exercise_provider.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

GetIt container = GetIt.instance;

Future<void> setupContainer() async {
  await registerDatabases();
  await registerRepositories();
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

Future<void> registerHandlers() async {
  container.registerFactory<GetExercisesQueryHandler>(
    () => GetExercisesQueryHandler(
      repository: container<ExerciseRepositoryInterface>(),
    ),
  );
  container.registerFactory<AddExerciseCommandHandler>(
    () => AddExerciseCommandHandler(
      repository: container<ExerciseRepositoryInterface>(),
    ),
  );
  container.registerFactory<DeleteExerciseCommandHandler>(
    () => DeleteExerciseCommandHandler(
      repository: container<ExerciseRepositoryInterface>(),
    ),
  );
  container.registerFactory<UpdateExerciseCommandHandler>(
    () => UpdateExerciseCommandHandler(
      repository: container<ExerciseRepositoryInterface>(),
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
