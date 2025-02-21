import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/pages/session/current_session_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_widget.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class SessionCardWidget extends StatelessWidget {
  final Session session;

  const SessionCardWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: session.workout().name().value(),
      subtitle:
          session.inProgress() ? "Started ${timeago.format(session.startDate())}" : "Finished ${timeago.format(session.endDate()!)}",
          // TODO: onEdit if finished -> possible to edit past session
      onStart: session.inProgress()
          ? () async {
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
            }
          : null,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: stats if session finished
            // TODO: finishedExercises only if session finished
            ...session.sessionExercises().value().map(
              (sessionExercise) {
                return Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    '${sessionExercise.sets().count()} set${sessionExercise.sets().count() > 1 ? 's' : ''} ${sessionExercise.workoutExercise().exercise().name().value()}',
                    style: TextStyle(
                      color: AppColorScheme.onPrimary,
                      fontSize: 13.0,
                    ),
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
