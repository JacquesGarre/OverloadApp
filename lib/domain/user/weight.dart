import 'package:overload/domain/user/exception/invalid_weight_exception.dart';

class Weight {

  final num _value;

  Weight._({required num value}) : _value = value;

  static Weight fromNum(num value) {
    assertValid(value);
    return Weight._(value: value);
  }

  static assertValid(num value) {
    if (value <= 0) {
      throw InvalidWeightException();
    }
  }

  num value() {
    return _value;
  }

  static Weight fromString(String value) {
    num numValue = num.parse(value);
    assertValid(numValue);
    return Weight._(value: numValue);
  }
}