import 'package:flutter/material.dart';
import 'package:overload/application/exercise/get_exercises_query/get_exercises_query.dart';
import 'package:overload/domain/exercise/exercise.dart';

class WorkoutProvider with ChangeNotifier {

  WorkoutProvider();

  List<Exercise> _exercises = [];
  List<Exercise> get exercises => _exercises;

  Future<void> loadExercises() async {
    GetExercisesQuery query = GetExercisesQuery();
    _exercises = await getExercisesQueryHandler.invoke(query);
    notifyListeners();
  }

}
