import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/units.dart';

class Exercise {
  final Id id;
  final Name name;
  final Units units;

  Exercise({
    required this.id,
    required this.name,
    required this.units,
  });

  static Exercise create(Name name, Units units) {
    return Exercise(
      id: Id.create(),
      name: name,
      units: units,
    );
    // TODO domain event
  }

  Exercise update(Name newName, Units newUnits) {
    return Exercise(
      id: id,
      name: newName,
      units: newUnits,
    );
    // TODO domain event
  }

  delete() {
    // TODO domain event
  }
}
