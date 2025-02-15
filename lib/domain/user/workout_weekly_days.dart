import 'package:overload/domain/user/exception/invalid_workout_weekly_days_exception.dart';

class WorkoutWeeklyDays {

  final int _value;

  WorkoutWeeklyDays._({required int value}) : _value = value;

  static WorkoutWeeklyDays fromInt(int value) {
    assertValid(value);
    return WorkoutWeeklyDays._(value: value);
  }

  static assertValid(int value) {
    if (value < 1 || value > 7) {
      throw InvalidWorkoutWeeklyDaysException();
    }
  }

  int value() {
    return _value;
  }

}