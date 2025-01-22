import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/dropdown_widget.dart';
import 'package:provider/provider.dart';
import 'package:overload/domain/exercise/exercise.dart';

class ExerciseDropdownWidget extends StatefulWidget {
  final ValueChanged<Exercise?> onChanged;
  final Exercise? initialExercise;

  const ExerciseDropdownWidget({
    super.key,
    required this.onChanged,
    this.initialExercise,
  });

  @override
  State<ExerciseDropdownWidget> createState() => _ExerciseDropdownWidgetState();
}

class _ExerciseDropdownWidgetState extends State<ExerciseDropdownWidget> {
  late ExerciseProvider _exerciseProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    await _exerciseProvider.loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseProvider>(
      builder: (context, exerciseProvider, child) {
        final exercises = exerciseProvider.exercises;
        return DropdownWidget(
          readonly: widget.initialExercise == null,
          items: exercises,
          searchFunction: exerciseProvider.searchByName,
          placeholder: 'Select exercise',
          onChanged: widget.onChanged,
        );
      },
    );
  }
}
