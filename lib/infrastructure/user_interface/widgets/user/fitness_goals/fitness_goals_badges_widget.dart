import 'package:flutter/material.dart';
import 'package:overload/domain/user/fitness_goals.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/badge_widget.dart';

class FitnessGoalsBadgesWidget extends StatelessWidget {
  final FitnessGoals fitnessGoals;

  const FitnessGoalsBadgesWidget({super.key, required this.fitnessGoals});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      runSpacing: 0.0,
      children: fitnessGoals.value().map((fitnessGoal) {
        return BadgeWidget(text: fitnessGoal.name);
      }).toList(),
    );
  }
}
