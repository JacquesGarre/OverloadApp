import 'package:overload/domain/workout/workout_exercises.dart';

class AddWorkoutCommand {
  final String name;
  final WorkoutExercises workoutExercises;
  final String? notes;

  AddWorkoutCommand({
    required this.name,
    required this.workoutExercises,
    this.notes
  });
}
