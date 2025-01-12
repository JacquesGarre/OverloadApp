class UpdateExerciseCommand {
  final String id;
  final String name;
  final List<String> units;

  UpdateExerciseCommand({
    required this.id,
    required this.name,
    required this.units,
  });
}
