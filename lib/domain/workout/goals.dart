import 'package:overload/domain/workout/goal/goal.dart';
import 'package:overload/domain/workout/sets.dart';

class Goals {
  final List<Goal> _value;

  Goals({
    required List<Goal> value,
  }) : _value = List.unmodifiable(value);

  List<Goal> value() {
    return _value;
  }

  int count() {
    return _value.length;
  }

  static Goals empty() {
    return Goals(value: []);
  }

  Goals add(Goal goal) {
    List<Goal> newValue = List.from(_value);
    newValue.add(goal);
    return Goals(value: newValue);
  }

  Goals removeAt(int index) {
    List<Goal> newValue = List.from(_value);
    newValue.removeAt(index);
    return Goals(value: newValue);
  }

  Goals updateAt(int index, Sets newSets) {
    List<Goal> newValue = List.from(_value);
    newValue[index] = Goal(
      id: newValue[index].id(),
      sets: newSets,
    );
    return Goals(value: newValue);
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> json = [];
    for(Goal goal in _value) {
      json.add(goal.toJson());
    }
    return json;
  }

  static Goals fromJson(List<Map<String, dynamic>> jsons) {
    List<Goal> value = [];
    for(Map<String, dynamic> json in jsons) {
      value.add(Goal.fromJson(json));
    }
    return Goals(value: value);
  }

}
