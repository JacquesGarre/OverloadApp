import 'package:overload/domain/workout/goal/id.dart';
import 'package:overload/domain/workout/sets.dart';

class Goal {
  final Id _id;
  final Sets _sets;

  Goal({
    required Sets sets,
    required Id id,
  })  : _sets = sets,
        _id = id;

  Id id() {
    return _id;
  }

  Sets sets() {
    return _sets;
  }

  static Goal fromSets(
    Sets sets,
  ) {
    Sets newSets = Sets(value: List.unmodifiable(sets.value()));
    return Goal(
      id: Id.create(),
      sets: newSets,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id.toString(),
      "sets": _sets.toJson(),
    };
  }

  static Goal fromJson(Map<String, dynamic> json) {
    return Goal(
      sets: Sets.fromJson(json["sets"]),
      id: Id.fromString(json["id"]),
    );
  }
}
