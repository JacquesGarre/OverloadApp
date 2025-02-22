import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/pages/session/finished_session_summary_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/delete_session_confirmation_modal_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/session_stats_table_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/card_widget.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class FinishedSessionCardWidget extends StatelessWidget {
  final Session session;

  const FinishedSessionCardWidget({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: session.workout().name().value(),
      subtitle: "Finished ${timeago.format(session.endDate()!)}",
      menuChildren: [
        MenuItemButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FinishedSessionSummaryPage(
                    sessionId: session.id(),
                  ),
                ),
              );
            },
            child: const Text("Show summary")),
        MenuItemButton(onPressed: () {}, child: const Text("Edit session")),
        MenuItemButton(
            onPressed: () {
              SessionProvider sessionProvider = Provider.of<SessionProvider>(
                context,
                listen: false,
              );
              showDeleteSessionConfirmationModal(
                context: context,
                sessionProvider: sessionProvider,
                session: session,
              );
            },
            child: const Text("Delete session")),
      ],
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SessionStatsTableWidget(session: session),
            const SizedBox(
              height: 5.0,
            ),
            Divider(
              color: AppColorScheme.onLightBackground,
            ),
            ...session.sessionExercises().withAtLeastOneSetDone().value().map(
              (sessionExercise) {
                return Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    '${sessionExercise.finishedSetsCount()} set${sessionExercise.finishedSetsCount() > 1 ? 's' : ''} ${sessionExercise.workoutExercise().exercise().name().value()}',
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
