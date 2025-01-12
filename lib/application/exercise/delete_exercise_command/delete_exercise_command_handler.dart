import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command.dart';
import 'package:overload/domain/exercise/exception/exercise_not_found_exception.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/exercise_repository_interface.dart';
import 'package:overload/domain/exercise/id.dart';

class DeleteExerciseCommandHandler {
  final ExerciseRepositoryInterface repository;

  DeleteExerciseCommandHandler({required this.repository});

  Future<void> invoke(DeleteExerciseCommand command) async {
    Id id = Id.fromString(command.id);
    Exercise? exercise = await repository.ofId(id);
    if (exercise == null) {
      throw ExerciseNotFoundException();
    }
    exercise.delete(); // TODO: Publish event
    await repository.delete(exercise);
  }
}
