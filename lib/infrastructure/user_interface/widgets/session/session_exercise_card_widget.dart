import 'package:flutter/material.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/sets/sets_table_widget.dart';

class SessionExerciseCardWidget extends StatefulWidget {
  final SessionExercise sessionExercise;

  const SessionExerciseCardWidget({
    super.key,
    required this.sessionExercise,
  });

  @override
  State<SessionExerciseCardWidget> createState() =>
      _SessionExerciseCardWidgetState();
}

class _SessionExerciseCardWidgetState extends State<SessionExerciseCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 8.0),
      child: Card(
        key: ValueKey(
          "sessionExercise${widget.sessionExercise.index().value()}",
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
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
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
                exercise: widget.sessionExercise.workoutExercise().exercise(),
                sets: widget.sessionExercise.sets(),
                checkable: true,
                setsNumberSelector: true,
                readonly: false,
                onSetsUpdated: (updatedSets) {
                  // widget.onUpdate(
                  //   widget.index,
                  //   updatedSets,
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
