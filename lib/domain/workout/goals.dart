import 'package:overload/domain/workout/goal.dart';

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
}
