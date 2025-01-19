import 'package:overload/domain/workout/goal.dart';

class Goals {
  final List<Goal> value;

  Goals(this.value);

  int count() {
    return value.length;
  }

  Goals add(Goal goal) {
    List<Goal> newValue = value;
    newValue.add(goal);
    return Goals(newValue);
  }

  Goals removeAt(int index) {
    List<Goal> newValue = value;
    newValue.removeAt(index);
    return Goals(newValue);
  }

}