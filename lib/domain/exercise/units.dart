import 'package:overload/domain/exercise/unit.dart';

class Units {
  final List<Unit> value;

  Units._({required this.value});

  static Units fromUnitList(List<Unit> value) {
    return Units._(value: value);
  }
}
