import 'package:overload/domain/workout/sets.dart';

class Goal {
  final Sets sets;

  Goal({
    required this.sets,
  });

  static Goal fromSets(Sets sets) {
    Sets newSets = Sets(value: List.from(sets.value));
    return Goal(
      sets: newSets,
    );
  }

  @override
  String toString() {
    return "Goal | ${sets.toString()}";
  }

}
