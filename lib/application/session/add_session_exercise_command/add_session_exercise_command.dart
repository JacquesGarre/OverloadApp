import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';

class AddSessionExerciseCommand {
  final Id id;
  final SessionExercise exercise;

  AddSessionExerciseCommand({
    required this.id,
    required this.exercise,
  });
}
