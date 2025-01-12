import 'package:overload/application/exercise/delete_exercise_command/delete_exercise_command.dart';
import 'package:overload/domain/exercise/id.dart';

class DeleteExerciseCommandHandler {

  void invoke(DeleteExerciseCommand command) {
    Id id = Id.fromString(command.id);
  }

}