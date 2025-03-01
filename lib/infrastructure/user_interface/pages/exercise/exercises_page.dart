import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/pages/exercise/add_exercise_page.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/user_interface/widgets/exercise/exercise_card_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/list_page_widget.dart';
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
      Provider.of<ExerciseProvider>(
        context,
        listen: false,
      ).loadExercises();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ExerciseProvider exerciseProvider = Provider.of<ExerciseProvider>(
      context,
    );
    return ListPageWidget(
      itemsCount: exerciseProvider.exercises.length,
      emptyListText:
          "Looks like your exercises list is taking a rest day! Add a new exercise to get started.",
      list: ListView.separated(
        itemCount: exerciseProvider.exercises.length,
        itemBuilder: (context, index) {
          return ExerciseCardWidget(
            exercise: exerciseProvider.exercises[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
      onFloatingActionButtonPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddExercisePage(),
          ),
        );
      },
    );
  }
}
