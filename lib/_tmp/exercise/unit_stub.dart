import 'dart:math';
import 'package:overload/domain/exercise/unit.dart';

class UnitStub {
  static Unit random() {
    List<Unit> all = Unit.all();
    Random random = Random();
    int randomIndex = random.nextInt(all.length);
    return all[randomIndex];
  }
}
