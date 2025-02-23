import 'package:overload/domain/user/user.dart';
import 'package:overload/domain/workout/workout.dart';

abstract class WorkoutGeneratorInterface {
  Future<List<Workout>> generateFromUser(User user);
}
