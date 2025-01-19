import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/set/metrics.dart';
import 'package:overload/domain/workout/set/set.dart';
import 'package:overload/domain/workout/set/set_index.dart';

class Sets {
  final List<Set> _value;

  Sets({
    required value,
  }) : _value = List.unmodifiable(value);

  List<Set> value() {
    return _value;
  }

  Sets add(Set set) {
    List<Set> newValue = List.from(_value);
    newValue.add(set);
    return Sets(value: newValue);
  }

  Sets addSetFromExercise(Exercise exercise) {
    List<Set> newValue = List.from(_value);
    Set? set = lastSet();
    SetIndex index = SetIndex.nextFromSetIndex(set?.index());
    Metrics metrics = Metrics.fromExercise(exercise);
    Set newSet = Set(index: index, metrics: metrics);
    newValue.add(newSet);
    return Sets(value: newValue);
  }

  Sets removeLastSet() {
    List<Set> newValue = List.from(_value);
    if (newValue.isEmpty) {
      return Sets(value: []);
    }
    newValue.removeLast();
    return Sets(value: newValue);
  }

  Sets updateSet(SetIndex index, Metric metric) {
    List<Set> newValue = List.from(_value);
    for (int i = 0; i < newValue.length; i++) {
      if (newValue[i].index().equals(index)) {
        newValue[i] = newValue[i].updateMetric(metric);
        break;
      }
    }
    return Sets(value: List.unmodifiable(newValue));
  }

  bool has(SetIndex index) {
    for(Set set in _value) {
      if (set.index().equals(index)) {
        return true;
      }
    }
    return false;
  }

  Set? findByIndex(SetIndex index) {
    for(Set set in _value) {
      if (set.index().equals(index)) {
        return set;
      }
    }
    return null;
  }

  Set? lastSet() {
    if (_value.isEmpty) {
      return null;
    }
    return _value.last;
  }

  int count() {
    return _value.length;
  }

  static Sets empty() {
    return Sets(value: []);
  }

  @override
  String toString() {
    String string = "SETS";
    for(Set set in _value) {
      string = "$string | ${set.toString()}";
    }
    return string;
  }
}
