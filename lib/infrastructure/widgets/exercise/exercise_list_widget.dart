import 'package:flutter/material.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_card_widget.dart';

class ExerciseList extends StatelessWidget {
  final List exercises;

  const ExerciseList({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseCardWidget(
          exercise: exercises[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}
