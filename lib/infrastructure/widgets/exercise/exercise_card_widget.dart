import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class ExerciseCardWidget extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCardWidget({super.key, required this.exercise});

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
                    exercise.name.value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 0.0,
                    children: exercise.units.value.map((unit) {
                      return Chip(
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 0.0,
                        ),
                        label: Text(
                          unit.value,
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
                    }).toList(),
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
                    // Handle edit action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: AppColorScheme.primary,
                  onPressed: () {
                    // Handle delete action
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