import 'package:flutter/material.dart';
import 'package:overload/_tmp/workout/goal/goal_stub.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goal.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/widgets/sets/sets_table_widget.dart';
import 'package:timelines_plus/timelines_plus.dart';

class GoalsTimelineWidget extends StatefulWidget {
  final Exercise exercise;
  final Sets sets;

  const GoalsTimelineWidget({
    super.key,
    required this.exercise,
    required this.sets,
  });

  @override
  State<GoalsTimelineWidget> createState() => _GoalsTimelineWidgetState();
}

class _GoalsTimelineWidgetState extends State<GoalsTimelineWidget> {
  Goals? goals;

  @override
  void initState() {
    super.initState();
    goals = Goals([
      GoalStub.fromSets(widget.sets),
      GoalStub.fromSets(widget.sets),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20.0,
        10,
        20,
        40,
      ),
      child: FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          color: const Color(0xff989898),
          indicatorTheme: IndicatorThemeData(
            // Theme of the circle on the line
            color: AppColorScheme.onLightBackground,
            position: 0.08,
            size: 15.0,
          ),
          connectorTheme: ConnectorThemeData(
            // Theme of the line
            color: AppColorScheme.onLightBackground,
            thickness: 2,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemCount: goals!.count(),
          contentsBuilder: (_, index) {
            Goal goal = goals!.value[index];
            bool goalIsAchieved = false; // TODO: Goal is achieved = false
            if (goalIsAchieved) return null;
            return Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
              child: Card(
                shadowColor: Colors.transparent,
                color: AppColorScheme.lightBackground,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Objective ${index + 1}",
                        style: TextStyle(
                            color: AppColorScheme.onLightBackground,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      SetsTableWidget(
                          exercise: widget.exercise,
                          sets: goal.sets,
                          checkable: false)
                      //_InnerTimeline(messages: processes[index].messages),
                    ],
                  ),
                ),
              ),
            );
          },
          indicatorBuilder: (_, index) {
            bool goalIsAchieved = false;
            if (goalIsAchieved) {
              // TODO: If goal is achieved
              return const DotIndicator(
                color: Color(0xff66c97f),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12.0,
                ),
              );
            } else {
              return const OutlinedDotIndicator(
                borderWidth: 1.5,
              );
            }
          },
          connectorBuilder: (_, index, ___) {
            bool goalIsAchieved = false; // TODO: Update based on your logic
            return goalIsAchieved
                ? const SolidLineConnector(
                    color: Color(0xff66c97f), // Green for achieved goals
                  )
                : DashedLineConnector(
                    color: AppColorScheme
                        .onLightBackground, // Dashed line for pending goals
                    gap: 5.0, // Space between dashes
                    thickness: 1.0, // Thickness of dashes
                  );
          },
        ),
      ),
    );
  }
}
