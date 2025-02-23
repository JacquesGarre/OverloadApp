import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/infrastructure/providers/user_provider.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/progress_icon_widget.dart';
import 'package:provider/provider.dart';

class SessionExerciseStatsTableWidget extends StatefulWidget {
  final Session session;
  final SessionExercise sessionExercise;

  const SessionExerciseStatsTableWidget({
    super.key,
    required this.session,
    required this.sessionExercise
  });

  @override
  State<SessionExerciseStatsTableWidget> createState() =>
      _SessionExerciseStatsTableWidgetState();
}

class _SessionExerciseStatsTableWidgetState extends State<SessionExerciseStatsTableWidget> {

  SessionExercise? previousExercise;

  @override
  void initState() {
    super.initState();
    if (widget.session.previousSession() != null) {
      setState(() {
        previousExercise = widget.session.previousSession()!.findSessionExercise(widget.sessionExercise.workoutExercise());
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Table(
      children: [
        TableRow(
          children: [
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
          ],
        ),
        TableRow(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.sessionExercise.finishedSetsCount()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColorScheme.onPrimary,
                    fontSize: 12,
                  ),
                ),
                if (previousExercise != null)
                  ProgressIconWidget(
                    currentValue: widget.sessionExercise.finishedSetsCount(),
                    previousValue: previousExercise!.finishedSetsCount(),
                  )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.sessionExercise.finishedRepsCount()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColorScheme.onPrimary,
                    fontSize: 12,
                  ),
                ),
                if (previousExercise != null)
                  ProgressIconWidget(
                    currentValue: widget.sessionExercise.finishedRepsCount(),
                    previousValue: previousExercise!.finishedRepsCount(),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.sessionExercise.finishedVolume(userProvider.user!.weight())} kgs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColorScheme.onPrimary,
                    fontSize: 12,
                  ),
                ),
                if (previousExercise != null)
                  ProgressIconWidget(
                    currentValue: widget.sessionExercise.finishedVolume(userProvider.user!.weight()),
                    previousValue: previousExercise!.finishedVolume(userProvider.user!.weight()),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
