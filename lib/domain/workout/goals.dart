import 'package:overload/domain/workout/goal.dart';

class Goals {
  final List<Goal> value;

  Goals(this.value);

  int count() {
    return value.length;
  }

}