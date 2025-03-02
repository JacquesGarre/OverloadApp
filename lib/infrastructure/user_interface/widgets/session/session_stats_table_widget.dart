import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/infrastructure/providers/user_provider.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/progress_icon_widget.dart';
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
            if (widget.session.hasUnit(Unit.reps))
              Text(
                "Reps",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColorScheme.onLightBackground,
                  fontSize: 12,
                ),
              ),
            if (widget.session.hasUnit(Unit.kgs))
              Text(
                "Volume",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColorScheme.onLightBackground,
                  fontSize: 12,
                ),
              ),
            if (widget.session.hasUnit(Unit.kmh))
              Text(
                "Average km/h",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColorScheme.onLightBackground,
                  fontSize: 12,
                ),
              ),
            if (widget.session.hasUnit(Unit.kms))
              Text(
                "Kms",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColorScheme.onLightBackground,
                  fontSize: 12,
                ),
              ),
          ],
        ),
        TableRow(
          children: [
            const SizedBox(
              height: 4.0,
            ),
            const SizedBox(
              height: 4.0,
            ),
            if (widget.session.hasUnit(Unit.reps))
              const SizedBox(
                height: 4.0,
              ),
            if (widget.session.hasUnit(Unit.kgs))
              const SizedBox(
                height: 4.0,
              ),
            if (widget.session.hasUnit(Unit.kmh))
              const SizedBox(
                height: 4.0,
              ),
            if (widget.session.hasUnit(Unit.kms))
              const SizedBox(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.session.finishedSetsCount()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColorScheme.onPrimary,
                    fontSize: 12,
                  ),
                ),
                if (widget.session.previousSession() != null)
                  ProgressIconWidget(
                    currentValue: widget.session.finishedSetsCount(),
                    previousValue:
                        widget.session.previousSession()!.finishedSetsCount(),
                  )
              ],
            ),
            if (widget.session.hasUnit(Unit.reps))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.session.finishedRepsCount()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColorScheme.onPrimary,
                      fontSize: 12,
                    ),
                  ),
                  if (widget.session.previousSession() != null)
                    ProgressIconWidget(
                      currentValue: widget.session.finishedRepsCount(),
                      previousValue:
                          widget.session.previousSession()!.finishedRepsCount(),
                    ),
                ],
              ),
            if (widget.session.hasUnit(Unit.kgs))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.session.finishedVolume(userProvider.user!.weight())} kgs",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColorScheme.onPrimary,
                      fontSize: 12,
                    ),
                  ),
                  if (widget.session.previousSession() != null)
                    ProgressIconWidget(
                      currentValue: widget.session
                          .finishedVolume(userProvider.user!.weight()),
                      previousValue: widget.session
                          .previousSession()!
                          .finishedVolume(userProvider.user!.weight()),
                    ),
                ],
              ),
            if (widget.session.hasUnit(Unit.kmh))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.session.averageSpeed()} km/h",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColorScheme.onPrimary,
                      fontSize: 12,
                    ),
                  ),
                  if (widget.session.previousSession() != null)
                    ProgressIconWidget(
                      currentValue: widget.session.averageSpeed(),
                      previousValue:
                          widget.session.previousSession()!.averageSpeed(),
                    ),
                ],
              ),
            if (widget.session.hasUnit(Unit.kms))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.session.distance()} kms",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColorScheme.onPrimary,
                      fontSize: 12,
                    ),
                  ),
                  if (widget.session.previousSession() != null)
                    ProgressIconWidget(
                      currentValue: widget.session.distance(),
                      previousValue:
                          widget.session.previousSession()!.distance(),
                    ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
