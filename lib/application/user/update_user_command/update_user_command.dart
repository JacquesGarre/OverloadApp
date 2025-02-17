class UpdateUserCommand {
  final int? workoutDurationPreference;
  final List<String>? fitnessGoals;
  final int? workoutWeeklyDays;
  final String? fitnessLevel;
  final List<String>? trainingTypes;
  final List<String>? trainingLocations;
  final List<String>? equipment;

  UpdateUserCommand({
    this.workoutDurationPreference,
    this.fitnessGoals,
    this.workoutWeeklyDays,
    this.fitnessLevel,
    this.trainingTypes,
    this.trainingLocations,
    this.equipment,
  });
}
