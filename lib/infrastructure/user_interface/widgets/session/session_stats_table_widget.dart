import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/infrastructure/providers/user_provider.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/chrono_timer_widget.dart';
import 'package:provider/provider.dart';

class SessionStatsTableWidget extends StatefulWidget {
  final Session session;

  const SessionStatsTableWidget({
    super.key,
    required this.session,
  });

  @override
  State<SessionStatsTableWidget> createState() =>
      _SessionStatsTableWidgetState();
}

class _SessionStatsTableWidgetState extends State<SessionStatsTableWidget> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Table(
      children: [
        TableRow(
          children: [
            Text(
              "Duration",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColorScheme.onLightBackground,
                fontSize: 12,
              ),
            ),
            Text(
              "Sets",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColorScheme.onLightBackground,
                fontSize: 12,
              ),
            ),
            Text(
              "Reps",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColorScheme.onLightBackground,
                fontSize: 12,
              ),
            ),
            Text(
              "Volume",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColorScheme.onLightBackground,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const TableRow(
          children: [
            SizedBox(
              height: 4.0,
            ),
            SizedBox(
              height: 4.0,
            ),
            SizedBox(
              height: 4.0,
            ),
            SizedBox(
              height: 4.0,
            ),
          ],
        ),
        TableRow(
          children: [
            ChronoTimerWidget(
              startDate: widget.session.startDate(),
              endDate: widget.session.endDate(),
            ),
            Text(
              "${widget.session.finishedSetsCount()}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColorScheme.onPrimary,
                fontSize: 12,
              ),
            ),
            Text(
              "${widget.session.finishedRepsCount()}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColorScheme.onPrimary,
                fontSize: 12,
              ),
            ),
            Text(
              "${widget.session.finishedVolume(userProvider.user!.weight())} kgs",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColorScheme.onPrimary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
