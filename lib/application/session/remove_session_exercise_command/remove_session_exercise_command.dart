import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';

class RemoveSessionExerciseCommand {
  final Id id;
  final SessionExercise exercise;

  RemoveSessionExerciseCommand({
    required this.id,
    required this.exercise,
  });
}
