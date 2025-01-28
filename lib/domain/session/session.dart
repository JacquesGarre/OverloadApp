import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session_exercises.dart';

class Session {
  final Id id;
  final DateTime startDate;
  final SessionExercises exercises;

  Session._({
    required this.id,
    required this.startDate,
    required this.exercises,
  });
}
