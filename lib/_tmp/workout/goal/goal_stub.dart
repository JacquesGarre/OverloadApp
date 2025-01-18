import 'package:overload/domain/workout/goal.dart';
import 'package:overload/domain/workout/sets.dart';


class GoalStub {
  static Goal fromSets(Sets sets) {
    return Goal(
      sets: sets,
    );
  }
}
