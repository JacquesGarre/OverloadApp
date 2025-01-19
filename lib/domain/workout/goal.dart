import 'package:overload/domain/workout/sets.dart';

class Goal {
  final Sets _sets;

  Goal({
    required Sets sets,
  }) : _sets = sets;

  Sets sets() {
    return _sets;
  }

  static Goal fromSets(Sets sets) {
    Sets newSets = Sets(value: List.unmodifiable(sets.value()));
    return Goal(
      sets: newSets,
    );
  }

  @override
  String toString() {
    return _sets.toString();
  }
}
