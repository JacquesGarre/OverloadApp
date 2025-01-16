import 'package:faker/faker.dart';
import 'package:overload/domain/workout/goal/operator.dart';

class OperatorStub {
  static Operator random() {
    List<Operator> all = Operator.all();
    int randomIndex = faker.randomGenerator.integer(all.length-1, min: 0);
    return all[randomIndex];
  }
}