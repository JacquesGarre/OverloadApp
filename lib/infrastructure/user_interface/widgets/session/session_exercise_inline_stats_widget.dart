import 'package:flutter/material.dart';
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
          "${widget.sessionExercise.finishedSetsCount()} sets",
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
        const SizedBox(
          width: 15.0,
        ),
        Text(
          "${widget.sessionExercise.finishedRepsCount()} reps",
          style: TextStyle(
            color: AppColorScheme.onPrimary,
            fontSize: 13.0,
          ),
        ),
        if (previousExercise != null)
          ProgressIconWidget(
            currentValue: widget.sessionExercise.finishedRepsCount(),
            previousValue: previousExercise!.finishedRepsCount(),
          ),
        const SizedBox(
          width: 15.0,
        ),
        Text(
          "${widget.sessionExercise.finishedVolume(userProvider.user!.weight())} kgs",
          style: TextStyle(
            color: AppColorScheme.onPrimary,
            fontSize: 13.0,
          ),
        ),
        if (previousExercise != null)
          ProgressIconWidget(
            currentValue: widget.sessionExercise
                .finishedVolume(userProvider.user!.weight()),
            previousValue:
                previousExercise!.finishedVolume(userProvider.user!.weight()),
          )
      ],
    );
  }
}
