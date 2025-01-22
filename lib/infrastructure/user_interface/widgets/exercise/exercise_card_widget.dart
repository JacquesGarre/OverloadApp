import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/user_interface/pages/exercise/edit_exercise_page.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/units/units_badges_widget.dart';
import 'package:provider/provider.dart';

class ExerciseCardWidget extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCardWidget({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: exercise.name().value(),
      onEdit: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditExercisePage(exercise: exercise),
          ),
        );
      },
      onDelete: () async {
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
      },
      child: UnitsBadgesWidget(units: exercise.units()),
    );
  }
}
