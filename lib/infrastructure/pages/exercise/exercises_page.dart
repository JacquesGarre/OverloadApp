import 'package:flutter/material.dart';
import 'package:overload/infrastructure/pages/exercise/add_exercise_page.dart';
import 'package:overload/infrastructure/providers/exercise/exercise_provider.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_card_widget.dart';
import 'package:provider/provider.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  static const String title = 'Exercises';

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExerciseProvider>(context, listen: false).loadExercises();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ExerciseProvider exerciseProvider =
        Provider.of<ExerciseProvider>(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
          child: ListView.separated(
            itemCount: exerciseProvider.exercises.length,
            itemBuilder: (context, index) {
              return ExerciseCardWidget(
                  exercise: exerciseProvider.exercises[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddExercisePage(),
                ),
              )
            },
            tooltip: 'Add Exercise',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
