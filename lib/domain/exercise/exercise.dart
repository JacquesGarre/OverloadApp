import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';

class Exercise {
  final Name name;
  final Units units;

  Exercise._({required this.name, required this.units});

  static Exercise fromNameAndUnit(Name name, Units units) {
    return Exercise._(
      name: name,
      units: units,
    );
  }
}
