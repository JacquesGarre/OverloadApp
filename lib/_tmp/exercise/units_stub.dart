import 'package:faker/faker.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/units.dart';

class UnitsStub {
  static Units random() {
    List<Unit> all = Unit.all();
    int randomNumber = faker.randomGenerator.integer(all.length, min: 1);
    List<Unit> value = [];
    for(var i = 0; i < randomNumber; i++) {
      value.add(all[i]);
    }
    return Units.fromUnitList(value);
  }
}