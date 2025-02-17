class UpdateUserCommand {
  final String? username;
  final int? age;
  final num? weight;
  final String? gender;
  final int? workoutDurationPreference;
  final List<String>? fitnessGoals;
  final int? workoutWeeklyDays;
  final String? fitnessLevel;
  final List<String>? trainingTypes;
  final List<String>? trainingLocations;
  final List<String>? equipment;

  UpdateUserCommand({
    this.username,
    this.age,
    this.weight,
    this.gender,
    this.workoutDurationPreference,
    this.fitnessGoals,
    this.workoutWeeklyDays,
    this.fitnessLevel,
    this.trainingTypes,
    this.trainingLocations,
    this.equipment,
  });
}
