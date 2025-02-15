class UpdateUserCommand {
  final int? workoutDurationPreference;
  final List<String>? fitnessGoals;
  final int? workoutWeeklyDays;

  UpdateUserCommand({
    this.workoutDurationPreference,
    this.fitnessGoals,
    this.workoutWeeklyDays,
  });
}
