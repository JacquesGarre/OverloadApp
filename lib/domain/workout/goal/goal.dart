import 'package:overload/domain/workout/goal/goal_progressions.dart';
import 'package:overload/domain/workout/sets.dart';

class Goal {
  final Sets targetSets;
  final GoalProgressions progressions;

  Goal({
    required this.targetSets,
    required this.progressions,
  });
}
