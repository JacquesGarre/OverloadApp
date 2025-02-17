import 'package:flutter/material.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/sets/sets_table_widget.dart';

class SessionExerciseCardWidget extends StatefulWidget {
  final SessionExercise sessionExercise;
  final void Function(SessionExercise updatedSessionExercise) onSessionExerciseUpdated;

  const SessionExerciseCardWidget({
    super.key,
    required this.sessionExercise,
    required this.onSessionExerciseUpdated,
  });

  @override
  State<SessionExerciseCardWidget> createState() =>
      _SessionExerciseCardWidgetState();
}

class _SessionExerciseCardWidgetState extends State<SessionExerciseCardWidget> {
  late SessionExercise sessionExercise;

  @override  
  void initState() {
    super.initState();
    sessionExercise = widget.sessionExercise;
  }

  void _updateSets(Sets updatedSets) {
    sessionExercise = sessionExercise.updateSets(updatedSets);
    widget.onSessionExerciseUpdated(sessionExercise);    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 8.0),
      child: Card(
        key: ValueKey(
          "sessionExercise${sessionExercise.index().value()}",
        ),
        shadowColor: Colors.transparent,
        color: AppColorScheme.lightBackground,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          6.0,
                          0.0,
                          6.0,
                          0.0,
                        ),
                        child: Text(
                          widget.sessionExercise
                              .workoutExercise()
                              .exercise()
                              .name()
                              .value(),
                          style: TextStyle(
                            color: AppColorScheme.primary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (widget.sessionExercise.workoutExercise().notes() !=
                          null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            6.0,
                            0.0,
                            6.0,
                            0.0,
                          ),
                          child: Text(
                            widget.sessionExercise
                                .workoutExercise()
                                .notes()!
                                .value(),
                            style: TextStyle(
                              color: AppColorScheme.onLightBackground,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      if (widget.sessionExercise.notes() !=
                          null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            6.0,
                            0.0,
                            6.0,
                            0.0,
                          ),
                          child: Text(
                            widget.sessionExercise
                                .notes()!
                                .value(),
                            style: TextStyle(
                              color: AppColorScheme.onLightBackground,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      //widget.onRemove(widget.index);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColorScheme.primary,
                    ),
                  ),
                ],
              ),
              Divider(
                color: AppColorScheme.onLightBackground,
              ),
              SetsTableWidget(
                exercise: sessionExercise.workoutExercise().exercise(),
                sets: sessionExercise.sets(),
                checkable: true,
                setsNumberSelector: true,
                readonly: false,
                onSetsUpdated: _updateSets,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
