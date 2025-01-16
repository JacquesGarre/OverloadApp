import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:provider/provider.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';
import 'dart:developer';

class ExerciseDropdownWidget extends StatelessWidget {

  final ValueChanged<Exercise?> onChange;

  const ExerciseDropdownWidget({
    super.key,
    required this.onChange,    
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseProvider>(
      builder: (context, exerciseProvider, child) {
        exerciseProvider.loadExercises();
        final exercises = exerciseProvider.exercises;
        return CustomDropdown<Exercise>.searchRequest(
          decoration: CustomDropdownDecoration(
            closedFillColor: AppColorScheme.lightBackground,
            expandedFillColor: AppColorScheme.lightBackground,
            hintStyle: TextStyle(
              color: AppColorScheme.onLightBackground,
            ),
            searchFieldDecoration: SearchFieldDecoration(
              fillColor: AppColorScheme.lightBackground,
              textStyle: TextStyle(
                color: AppColorScheme.onLightBackground,
                fontSize: 14.0,
              ),
              hintStyle: TextStyle(
                color: AppColorScheme.onLightBackground,
                fontSize: 14.0,
              ),
            ),
            listItemStyle: const TextStyle(
              fontSize: 14.0,
            ),
          ),
          futureRequest: (String query) => exerciseProvider.searchByName(query),
          hintText: 'Search exercise',
          items: exercises,
          onChanged: onChange,
        );
      },
    );
  }
}
