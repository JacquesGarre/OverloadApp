import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/set/metrics.dart';
import 'package:overload/domain/workout/set/set.dart';
import 'package:overload/domain/workout/set/set_index.dart';

class Sets {
  final List<Set> value;

  Sets({
    required this.value,
  });

  Sets add(Set set) {
    List<Set> newValue = value;
    newValue.add(set);
    return Sets(value: newValue);
  }

  Sets addSetFromExercise(Exercise exercise) {
    List<Set> newValue = value;
    Set? set = lastSet();
    SetIndex index = SetIndex.nextFromSetIndex(set?.index);
    Metrics metrics = Metrics.fromExercise(exercise);
    Set newSet = Set(index: index, metrics: metrics);
    newValue.add(newSet);
    return Sets(value: newValue);
  }

  Sets removeLastSet() {
    List<Set> newValue = value;
    if (newValue.isEmpty) {
      return Sets(value: []);
    }
    newValue.removeLast();
    return Sets(value: newValue);
  }

  bool has(SetIndex index) {
    for(Set set in value) {
      if (set.index.equals(index)) {
        return true;
      }
    }
    return false;
  }

  Set? findByIndex(SetIndex index) {
    for(Set set in value) {
      if (set.index.equals(index)) {
        return set;
      }
    }
    return null;
  }

  Set? lastSet() {
    if (value.isEmpty) {
      return null;
    }
    return value.last;
  }

  int count() {
    return value.length;
  }

  static Sets empty() {
    return Sets(value: []);
  }
}
