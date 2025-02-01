import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/set/metrics.dart';
import 'package:overload/domain/workout/set/set.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/workout_exercise/sets_count.dart';

class Sets {
  final List<Set> _value;

  Sets({
    required List<Set> value,
  }) : _value = List.unmodifiable(value);

  List<Set> value() {
    return _value;
  }

  Sets add(Set set) {
    List<Set> newValue = List.from(_value);
    newValue.add(set);
    return Sets(value: newValue);
  }

  static Sets fromSetsCountAndExercise(SetsCount setsCount, Exercise exercise) {
    List<Set> value = [];
    for (int i = 1; i <= setsCount.value(); i++) {
      SetIndex setIndex = SetIndex(value: i);
      Set set = Set.fromSetIndexAndExercise(setIndex, exercise);
      value.add(set);
    }
    return Sets(value: value);
  }

  Sets addSetFromExercise(Exercise exercise) {
    List<Set> newValue = List.from(_value);
    Set? set = lastSet();
    SetIndex index = SetIndex.nextFromSetIndex(set?.index());
    Metrics metrics = Metrics.fromExercise(exercise);
    Set newSet = Set(index: index, metrics: metrics, isDone: false);
    newValue.add(newSet);
    return Sets(value: newValue);
  }

  Sets clone() {
    return Sets(value: value());
  }

  Sets removeLastSet() {
    List<Set> newValue = List.from(_value);
    if (newValue.isEmpty) {
      return Sets(value: []);
    }
    newValue.removeLast();
    return Sets(value: newValue);
  }

  Sets update(int setIndexValue, int cellIndex, String value) {
    List<Set> newValue = List.from(_value);
    SetIndex setIndex = SetIndex(value: setIndexValue);
    for(int i in newValue.asMap().keys) {
      Set set = newValue[i];
      if (set.index().equals(setIndex)) {
        set = set.update(cellIndex, value);
        newValue[i] = set;
      }
    }
    return Sets(value: List.unmodifiable(newValue));
  }

  bool has(SetIndex index) {
    for (Set set in _value) {
      if (set.index().equals(index)) {
        return true;
      }
    }
    return false;
  }

  Set? findByIndex(SetIndex index) {
    for (Set set in _value) {
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

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> json = [];
    for (Set set in _value) {
      json.add(set.toJson());
    }
    return json;
  }

  static Sets fromJson(List<Map<String, dynamic>> jsons) {
    List<Set> value = [];
    for (Map<String, dynamic> json in jsons) {
      value.add(Set.fromJson(json));
    }
    return Sets(value: value);
  }
}
