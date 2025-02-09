class UpdateExerciseCommand {
  final String id;
  final String name;
  final List<String> units;
  final bool isBodyWeightExercise;

  UpdateExerciseCommand({
    required this.id,
    required this.name,
    required this.units,
    required this.isBodyWeightExercise,
  });
}
