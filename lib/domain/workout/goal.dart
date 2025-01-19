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
    String string = "Goal ";
    for(Set set in sets.value) {
      string = '$string | Set ${set.index.value} : ';
      for(Metric metric in set.metrics.value) {
        string = '$string${metric.value} ${metric.unit.name} ';
      }
    }
    return string;
  }

}
