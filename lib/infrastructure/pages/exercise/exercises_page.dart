import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/name.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/infrastructure/pages/exercise/add_exercise_page.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_card_widget.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  static const String title = 'Exercises';

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {

  final List<Exercise> _exercises = [
    Exercise.create(
      Name.fromString("Chest press"),
      Units.fromUnitList([
        Unit.reps,
        Unit.kgs,
        Unit.restTime,
      ]),
    ),
    Exercise.create(
      Name.fromString("Shoulder press"),
      Units.fromUnitList([
        Unit.reps,
        Unit.kgs,
        Unit.restTime,
      ]),
    ),
  ];

  void _addExercise(Exercise newExercise) {
    setState(() {
      _exercises.add(newExercise);
    });
  }

  Future<void> _navigateToAddExercisePage() async {
    final newExercise = await Navigator.push<Exercise>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddExercisePage(),
      ),
    );
    if (newExercise != null) {
      _addExercise(newExercise);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.separated(
            itemCount: _exercises.length,
            itemBuilder: (context, index) {
              return ExerciseCardWidget(exercise: _exercises[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: _navigateToAddExercisePage,
            tooltip: 'Add Exercise',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
