import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/pages/exercise/edit_exercise_page.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/widgets/shared/card_widget.dart';
import 'package:overload/infrastructure/widgets/shared/delete_button_widget.dart';
import 'package:overload/infrastructure/widgets/shared/edit_button_widget.dart';
import 'package:overload/infrastructure/widgets/units/units_badges_widget.dart';
import 'package:provider/provider.dart';

class ExerciseCardWidget extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCardWidget({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    void editExercise() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditExercisePage(exercise: exercise),
        ),
      );
    }

    Future<void> deleteExercice() async {
      try {
        ExerciseProvider exerciseProvider = Provider.of<ExerciseProvider>(
          context,
          listen: false,
        );
        await exerciseProvider.deleteExercice(exercise);
      } catch (e) {
        if (!context.mounted) return;
        ExceptionHandler().handleException(context, e);
      }
    }

    return CardWidget(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name().value(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5.0),
                UnitsBadgesWidget(units: exercise.units()),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              EditButtonWidget(onPressed: editExercise),
              DeleteButtonWidget(onPressed: deleteExercice),
            ],
          ),
        ],
      ),
    );
  }
}
