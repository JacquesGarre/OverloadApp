import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/widgets/shared/card_widget.dart';

class WorkoutCardWidget extends StatelessWidget {
  final Workout workout;

  const WorkoutCardWidget({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    void editWorkout() {}

    void deleteWorkout() {}

    return CardWidget(
      title: workout.name().value(),
      subtitle: workout.notes()?.value(),
      onEdit: editWorkout,
      onDelete: deleteWorkout,
      child: Text(
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
