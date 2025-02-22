import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/pages/session/current_session_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_widget.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class CurrentSessionCardWidget extends StatelessWidget {
  final Session session;

  const CurrentSessionCardWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: session.workout().name().value(),
      subtitle: "Started ${timeago.format(session.startDate())}",
      onStart: () async {
        SessionProvider sessionProvider = Provider.of<SessionProvider>(
          context,
          listen: false,
        );
        await sessionProvider.loadCurrentSession();
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CurrentSessionPage(
              sessionId: session.id(),
            ),
          ),
        );
      },
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...session.sessionExercises().value().map(
              (sessionExercise) {
                bool exerciseDone = sessionExercise.finishedSetsCount() ==
                    sessionExercise.sets().count();
                String progress =
                    '${sessionExercise.finishedSetsCount()} / ${sessionExercise.sets().count()}';
                String unit =
                    'set${sessionExercise.sets().count() > 1 ? 's' : ''}';
                String exerciseName =
                    sessionExercise.workoutExercise().exercise().name().value();
                return Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Row(
                    children: [
                      Text(
                        '$progress $unit $exerciseName',
                        style: TextStyle(
                          color: exerciseDone
                              ? AppColorScheme.onPrimary
                              : AppColorScheme.onLightBackground,
                          fontSize: 13.0,
                        ),
                      ),
                      if (exerciseDone)
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.check,
                            color: AppColorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ],
    );
  }
}
