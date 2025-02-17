import 'package:flutter/material.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/workout/id.dart' as workout;
import 'package:overload/domain/session/session_exercise/session_exercise_index.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/session_exercise_form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';

class AddSessionExercisePage extends StatelessWidget {
  final Id sessionId;
  final workout.Id workoutId;
  final SessionExerciseIndex index;

  const AddSessionExercisePage({
    super.key,
    required this.sessionId,
    required this.workoutId,
    required this.index,
  });

  static const String title = 'Add exercise to your session';

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      title: title,
      child: SingleChildScrollView(
        child: SessionExerciseFormWidget(
          sessionId: sessionId,
          workoutId: workoutId,
          index: index,
        ),
      ),
    );
  }
}
