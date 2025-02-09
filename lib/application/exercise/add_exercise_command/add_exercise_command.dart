class AddExerciseCommand {
  final String name;
  final List<String> units;
  final bool isBodyWeightExercise;

  AddExerciseCommand({
    required this.name,
    required this.units,
    required this.isBodyWeightExercise,
  });
}
