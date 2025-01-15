import 'package:overload/domain/workout/workout.dart';
import 'id_stub.dart';
import 'name_stub.dart';
import 'workout_exercises_stub.dart';

class WorkoutStub {
  static Workout random() {
    return Workout(
      id: IdStub.random(),
      name: NameStub.random(),
      exercises: WorkoutExercisesStub.random(),
    );
  }
}
