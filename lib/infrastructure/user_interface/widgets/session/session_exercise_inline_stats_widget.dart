import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/infrastructure/providers/user_provider.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/progress_icon_widget.dart';
import 'package:provider/provider.dart';

class SessionExerciseInlineStatsWidget extends StatefulWidget {
  final Session session;
  final SessionExercise sessionExercise;

  const SessionExerciseInlineStatsWidget(
      {super.key, required this.session, required this.sessionExercise});

  @override
  State<SessionExerciseInlineStatsWidget> createState() =>
      _SessionExerciseInlineStatsWidgetState();
}

class _SessionExerciseInlineStatsWidgetState
    extends State<SessionExerciseInlineStatsWidget> {
  SessionExercise? previousExercise;

  @override
  void initState() {
    super.initState();
    if (widget.session.previousSession() != null) {
      setState(() {
        previousExercise = widget.session
            .previousSession()!
            .findSessionExercise(widget.sessionExercise.workoutExercise());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Row(
      children: [
        Text(
          "${widget.sessionExercise.finishedSetsCount()} set${widget.sessionExercise.finishedSetsCount() > 1 ? 's':''}",
          style: TextStyle(
            color: AppColorScheme.onPrimary,
            fontSize: 13.0,
          ),
        ),
        if (previousExercise != null)
          ProgressIconWidget(
            currentValue: widget.sessionExercise.finishedSetsCount(),
            previousValue: previousExercise!.finishedSetsCount(),
          ),
        if (widget.sessionExercise.hasUnit(Unit.reps))
          const SizedBox(
            width: 15.0,
          ),
        if (widget.sessionExercise.hasUnit(Unit.reps))
          Text(
            "${widget.sessionExercise.finishedRepsCount()} reps",
            style: TextStyle(
              color: AppColorScheme.onPrimary,
              fontSize: 13.0,
            ),
          ),
        if (widget.sessionExercise.hasUnit(Unit.reps))
          if (previousExercise != null)
            ProgressIconWidget(
              currentValue: widget.sessionExercise.finishedRepsCount(),
              previousValue: previousExercise!.finishedRepsCount(),
            ),
        if (widget.sessionExercise.hasUnit(Unit.kgs))
          const SizedBox(
            width: 15.0,
          ),
        if (widget.sessionExercise.hasUnit(Unit.kgs))
          Text(
            "${widget.sessionExercise.finishedVolume(userProvider.user!.weight())} kgs",
            style: TextStyle(
              color: AppColorScheme.onPrimary,
              fontSize: 13.0,
            ),
          ),
        if (widget.sessionExercise.hasUnit(Unit.kgs))
          if (previousExercise != null)
            ProgressIconWidget(
              currentValue: widget.sessionExercise
                  .finishedVolume(userProvider.user!.weight()),
              previousValue:
                  previousExercise!.finishedVolume(userProvider.user!.weight()),
            ),
        if (widget.sessionExercise.hasUnit(Unit.kmh))
          const SizedBox(
            width: 15.0,
          ),
        if (widget.sessionExercise.hasUnit(Unit.kmh))
          Text(
            "${widget.sessionExercise.averageSpeed()} kmh",
            style: TextStyle(
              color: AppColorScheme.onPrimary,
              fontSize: 13.0,
            ),
          ),
        if (widget.sessionExercise.hasUnit(Unit.kmh))
          if (previousExercise != null)
            ProgressIconWidget(
              currentValue: widget.sessionExercise.averageSpeed(),
              previousValue:
                  previousExercise!.averageSpeed(),
            ),
        if (widget.sessionExercise.hasUnit(Unit.kms))
          const SizedBox(
            width: 15.0,
          ),
        if (widget.sessionExercise.hasUnit(Unit.kms))
          Text(
            "${widget.sessionExercise.distance()} kms",
            style: TextStyle(
              color: AppColorScheme.onPrimary,
              fontSize: 13.0,
            ),
          ),
        if (widget.sessionExercise.hasUnit(Unit.kms))
          if (previousExercise != null)
            ProgressIconWidget(
              currentValue: widget.sessionExercise.distance(),
              previousValue:
                  previousExercise!.distance(),
            )
      ],
    );
  }
}
