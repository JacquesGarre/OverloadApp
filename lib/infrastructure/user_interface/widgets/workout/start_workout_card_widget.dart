import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/pages/session/session_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_widget.dart';
import 'package:provider/provider.dart';

class StartWorkoutCardWidget extends StatelessWidget {
  final Workout workout;

  const StartWorkoutCardWidget({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(
      context,
      listen: false,
    );
    return CardWidget(
      title: workout.name().value(),
      subtitle: workout.notes()?.value(),
      onStart: () async {
        try {
          Session session = await sessionProvider.startSession(workout.id());
          if (!context.mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SessionPage(
                sessionId: session.id(),
              ),
            ),
          );
        } catch (e) {
          ExceptionHandler().handleException(context, e);
        }
      },
      headerChild: Text(
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
