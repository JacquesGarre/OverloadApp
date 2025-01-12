import 'package:get_it/get_it.dart';
import 'package:overload/application/exercise/add_exercise_command/add_exercise_command_handler.dart';
import 'package:overload/infrastructure/providers/exercise/exercise_provider.dart';

GetIt container = GetIt.instance;

Future<void> setupContainer() async {
  await registerHandlers();
  await registerProviders();
}

Future<void> registerHandlers() async {
  container.registerFactory<AddExerciseCommandHandler>(
    () => AddExerciseCommandHandler(),
  );
}

Future<void> registerProviders() async {
  container.registerSingleton<ExerciseProvider>(
    ExerciseProvider(
      addExerciseCommandHandler: container<AddExerciseCommandHandler>(),
    ),
  );
}
