import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';

class UpdateSessionExerciseCommand {
  final Id id;
  final SessionExercise exercise;

  UpdateSessionExerciseCommand({required this.id, required this.exercise});
}
