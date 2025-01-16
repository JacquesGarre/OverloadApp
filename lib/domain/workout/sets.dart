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

  bool has(SetIndex index) {
    for(Set set in value) {
      if (set.index.equals(index)) {
        return true;
      }
    }
    return false;
  }

  static Sets empty() {
    return Sets(value: []);
  }
}
