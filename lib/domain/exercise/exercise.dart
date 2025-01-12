import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';

class Exercise {

  final Id id;
  final Name name;
  final Units units;

  Exercise._({required this.id, required this.name, required this.units});

  static Exercise create(Name name, Units units) {
    return Exercise._(
      id: Id.create(),
      name: name,
      units: units,
    );
  }
}
