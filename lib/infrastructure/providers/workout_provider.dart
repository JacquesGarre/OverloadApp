import 'package:flutter/material.dart';
import 'package:overload/_tmp/workout/workout_stub.dart';
import 'package:overload/domain/workout/workout.dart';

class WorkoutProvider with ChangeNotifier {
  WorkoutProvider();

  List<Workout> _workouts = [];
  List<Workout> get workouts => _workouts;

  Future<void> loadWorkouts() async {
    _workouts = [
      WorkoutStub.random(),
      WorkoutStub.random(),
      WorkoutStub.random()
    ];
    notifyListeners();
  }
}
