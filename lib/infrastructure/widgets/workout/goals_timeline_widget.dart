import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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

  GoalsTimelineWidget({
    super.key,
    required this.exercise,
    required Sets sets,
  }) : sets = Sets(value: sets.value());

  @override
  State<GoalsTimelineWidget> createState() => GoalsTimelineWidgetState();
}

class GoalsTimelineWidgetState extends State<GoalsTimelineWidget> {

  Goals goals = Goals.empty();
  late Sets sets;

  @override
  void initState() {
    super.initState();
    setState(() {
      sets = widget.sets;
      goals = goals.add(Goal.fromSets(sets));
    });
  }

  void _addGoal() {
    setState(() {
      goals = goals.add(Goal.fromSets(sets));
    });
  }

  void _removeGoal(int index) {
    setState(() {
      goals = goals.removeAt(index);
    });
  }

  void _updateGoal(int index, Sets updatedSets) {
    setState(() {
      goals = goals.updatedAt(index, updatedSets);
    });
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
            position: 0.35,
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
          itemCount: goals.count() + 1,
          contentsBuilder: (_, index) {
            if (index < goals.count()) {
              // Render existing goals
              Goal goal = goals.value()[index];
              bool goalIsAchieved = false; // TODO: Goal is achieved = false
              if (goalIsAchieved) return null;
              return Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
                child: Card(
                  key: ValueKey("goal_${goal.hashCode}"),
                  shadowColor: Colors.transparent,
                  color: AppColorScheme.lightBackground,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                6.0,
                                0.0,
                                0.0,
                                0.0,
                              ),
                              child: Text(
                                "Objective ${index + 1}",
                                style: TextStyle(
                                  color: AppColorScheme.onLightBackground,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _removeGoal(index);
                              },
                              icon: Icon(
                                Icons.close,
                                color: AppColorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        SetsTableWidget(
                          exercise: widget.exercise,
                          sets: goal.sets(),
                          checkable: false,
                          onSetsUpdated: (updatedSets) {
                            _updateGoal(index, updatedSets);
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // Render "Add an Objective" button
              return Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
                child: ElevatedButton(
                  onPressed: _addGoal,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      AppColorScheme.lightBackground,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      AppColorScheme.primary,
                    ),
                  ),
                  child: const Text(
                    "Add new goal",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }
          },
          indicatorBuilder: (_, index) {
            if (index < goals.count()) {
              bool goalIsAchieved = false;
              if (goalIsAchieved) {
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
            } else {
              // Add indicator for the button
              return const OutlinedDotIndicator(
                borderWidth: 1.5,
              );
            }
          },
          connectorBuilder: (_, index, ___) {
            // The line style
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
