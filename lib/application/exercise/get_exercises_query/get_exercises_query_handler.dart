import 'package:overload/application/exercise/get_exercises_query/get_exercises_query.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/exercise_repository_interface.dart';

class GetExercisesQueryHandler {
  final ExerciseRepositoryInterface repository;

  GetExercisesQueryHandler({required this.repository});

  Future<List<Exercise>> invoke(GetExercisesQuery query) async {
    List<Exercise> exercises = await repository.findAll();
    return exercises;
  }
}
