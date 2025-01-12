import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_card.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  static const String title = 'Exercises';

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final List<Exercise> _exercises = [
    Exercise.fromNameAndUnit(
      Name.fromString("Chest press"),
      Units.fromUnitList([
        Unit.reps,
        Unit.kgs,
        Unit.restTime,
      ]),
    ),
    Exercise.fromNameAndUnit(
      Name.fromString("Shoulder press"),
      Units.fromUnitList([
        Unit.reps,
        Unit.kgs,
        Unit.restTime,
      ]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        itemCount: _exercises.length,
        itemBuilder: (context, index) {
          return ExerciseCard(exercise: _exercises[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
