class SessionExerciseIndex {
  final int _value;

  SessionExerciseIndex({required int value}) : _value = value;

  bool equals(SessionExerciseIndex index) {
    return _value == index.value();
  }

  int value() {
    return _value;
  }

  SessionExerciseIndex next() {
    return SessionExerciseIndex(value: _value+1);
  }

  static SessionExerciseIndex nextFromSessionExerciseIndex(
    SessionExerciseIndex? index,
  ) {
    if (index == null) {
      return SessionExerciseIndex(value: 1);
    }
    return SessionExerciseIndex(value: index.value() + 1);
  }

}
