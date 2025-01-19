import 'package:overload/domain/workout/sets.dart';

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
}
