import 'package:flutter/material.dart';
import 'package:overload/domain/user/fitness_goals.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class FitnessGoalBadgeWidget extends StatelessWidget {
  final FitnessGoalValue value;

  const FitnessGoalBadgeWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 0.0,
      ),
      label: Text(
        value.name,
        style: TextStyle(
          color: AppColorScheme.onSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: AppColorScheme.secondary,
      side: BorderSide.none,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
