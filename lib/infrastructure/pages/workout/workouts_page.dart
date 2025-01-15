import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/workout_provider.dart';
import 'package:overload/infrastructure/widgets/workout/workout_card_widget.dart';
import 'package:provider/provider.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  static const String title = 'Workouts';

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WorkoutProvider>(
        context,
        listen: false,
      ).loadWorkouts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final WorkoutProvider workoutProvider =
        Provider.of<WorkoutProvider>(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            12.0,
            0,
            12.0,
            0,
          ),
          child: ListView.separated(
            itemCount: workoutProvider.workouts.length,
            itemBuilder: (context, index) {
              return WorkoutCardWidget(
                workout: workoutProvider.workouts[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const AddExercisePage(),
              //   ),
              // )
            },
            tooltip: 'Add workout',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
