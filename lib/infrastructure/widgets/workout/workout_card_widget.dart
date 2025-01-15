import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class WorkoutCardWidget extends StatelessWidget {
  final Workout workout;

  const WorkoutCardWidget({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: AppColorScheme.lightBackground,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.name.value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: AppColorScheme.primary,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         UpdateWorkoutPage(workout: workout),
                    //   ),
                    // );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: AppColorScheme.primary,
                  onPressed: () async {
                    // try {
                    //   WorkoutProvider workoutProvider =
                    //       Provider.of<WorkoutProvider>(
                    //     context,
                    //     listen: false,
                    //   );
                    //   await workoutProvider.deleteExercice(workout);
                    // } catch (e) {
                    //   if (!context.mounted) return;
                    //   ExceptionHandler().handleException(context, e);
                    // }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
