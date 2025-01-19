import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/set/set.dart';

class Goal {
  final Sets sets;

  Goal({
    required this.sets,
  });

  static Goal fromSets(Sets sets) {
    return Goal(
      sets: sets,
    );
  }

  @override
  String toString() {
    return "Goal | ${sets.toString()}";
  }

}
