import 'package:overload/domain/workout/workout_exercises.dart';

class UpdateWorkoutCommand {
  final String id;
  final String name;
  final WorkoutExercises workoutExercises;
  final String? notes;

  UpdateWorkoutCommand({
    required this.id,
    required this.name,
    required this.workoutExercises,
    this.notes,
  });
}
