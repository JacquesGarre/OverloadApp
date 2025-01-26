class WorkoutExerciseIndex {
  final int _value;

  WorkoutExerciseIndex({required int value}) : _value = value;

  bool equals(WorkoutExerciseIndex index) {
    return _value == index.value();
  }

  int value() {
    return _value;
  }

  WorkoutExerciseIndex next() {
    return WorkoutExerciseIndex(value: _value+1);
  }

  static WorkoutExerciseIndex nextFromWorkoutExerciseIndex(
    WorkoutExerciseIndex? index,
  ) {
    if (index == null) {
      return WorkoutExerciseIndex(value: 1);
    }
    return WorkoutExerciseIndex(value: index.value() + 1);
  }

}
