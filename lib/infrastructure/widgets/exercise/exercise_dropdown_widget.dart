import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class ExerciseDropdownWidget extends StatefulWidget {
  
  final ValueChanged<Exercise?> onChange;
  final Exercise? initialExercise;

  const ExerciseDropdownWidget({
    super.key,
    required this.onChange,
    this.initialExercise,
  });

  @override
  State<ExerciseDropdownWidget> createState() => _ExerciseDropdownWidgetState();
}

class _ExerciseDropdownWidgetState extends State<ExerciseDropdownWidget> {
  late ExerciseProvider _exerciseProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    await _exerciseProvider.loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseProvider>(
      builder: (context, exerciseProvider, child) {
        final exercises = exerciseProvider.exercises;
        return Container(
          decoration: BoxDecoration(
            color: AppColorScheme.lightBackground,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: AppTheme
                      .theme.inputDecorationTheme.border?.borderSide.color ??
                  Colors.white,
              width: 1,
            ),
          ),
          child: CustomDropdown<Exercise>.searchRequest(
            initialItem: widget.initialExercise,
            decoration: CustomDropdownDecoration(
              closedFillColor: AppColorScheme.lightBackground,
              expandedFillColor: AppColorScheme.lightBackground,
              hintStyle: TextStyle(
                color: AppTheme.theme.inputDecorationTheme.hintStyle?.color,
              ),
              listItemDecoration: ListItemDecoration(
                selectedColor: AppColorScheme.lightBackground,
                splashColor: AppColorScheme.lightBackground,
                highlightColor: AppColorScheme.lightBackground,
              ),
              searchFieldDecoration: SearchFieldDecoration(
                fillColor: AppColorScheme.lightBackground,
                textStyle: TextStyle(
                  color: AppColorScheme.onLightBackground,
                  fontSize: 14.0,
                ),
                hintStyle: AppTheme.theme.inputDecorationTheme.hintStyle,
              ),
              listItemStyle: const TextStyle(
                fontSize: 14.0,
              ),
            ),
            futureRequest: (String query) =>
                exerciseProvider.searchByName(query),
            hintText: 'Select exercise',
            items: exercises,
            onChanged: widget.onChange,
          ),
        );
      },
    );
  }
}
