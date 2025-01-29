import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/workout_provider.dart';
import 'package:overload/infrastructure/user_interface/pages/workout/edit_workout_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_widget.dart';
import 'package:provider/provider.dart';

class WorkoutCardWidget extends StatelessWidget {
  final Workout workout;

  const WorkoutCardWidget({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: workout.name().value(),
      subtitle: workout.notes()?.value(),
      onEdit: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditWorkoutPage(workout: workout),
          ),
        );
      },
      onDelete: () async {
        try {
          WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(
            context,
            listen: false,
          );
          await workoutProvider.deleteWorkout(workout);
        } catch (e) {
          if (!context.mounted) return;
          ExceptionHandler().handleException(context, e);
        }
      },
      headerChild: Text(
        '${workout.exercisesCount()} exercise${workout.exercisesCount() > 1 ? 's' : ''}',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColorScheme.primary,
        ),
      ),
    );
  }
}
