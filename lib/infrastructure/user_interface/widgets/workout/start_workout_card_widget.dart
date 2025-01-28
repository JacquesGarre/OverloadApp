import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_widget.dart';

class StartWorkoutCardWidget extends StatelessWidget {
  final Workout workout;

  const StartWorkoutCardWidget({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: workout.name().value(),
      subtitle: workout.notes()?.value(),
      onStart: () {},
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
