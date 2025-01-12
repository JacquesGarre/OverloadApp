import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/id.dart';
import 'package:overload/domain/exercise/name.dart';

abstract class ExerciseRepositoryInterface {
  Future<void> add(Exercise exercise);
  Future<void> update(Exercise exercise);
  Future<void> delete(Exercise exercise);
  Future<Exercise?> ofId(Id id);
  Future<Exercise?> ofName(Name name);
  Future<List<Exercise>> findAll();
}
