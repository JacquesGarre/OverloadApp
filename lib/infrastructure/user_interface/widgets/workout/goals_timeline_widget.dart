import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goal.dart';
import 'package:overload/domain/workout/goals.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/secondary_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/goal_widget.dart';
import 'package:timelines_plus/timelines_plus.dart';

class GoalsTimelineWidget extends StatefulWidget {
  final Exercise exercise;
  final Sets sets;
  final Goals? existingGoals;

  GoalsTimelineWidget({
    super.key,
    required this.exercise,
    required Sets sets,
    this.existingGoals,
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
      if (widget.existingGoals != null) {
        goals = widget.existingGoals!;
      } else {
        goals = goals.add(Goal.fromSets(sets));
      }
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
    goals = goals.updateAt(
      index,
      updatedSets,
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            0,
            10,
            0,
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
                  Goal goal = goals.value()[index];
                  return GoalWidget(
                    index: index,
                    goal: goal,
                    exercise: widget.exercise,
                    onUpdate: _updateGoal,
                    onRemove: _removeGoal,
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
                    child: SecondaryButtonWidget(
                      text: "Add new goal",
                      onPressed: _addGoal,
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
        ),
      ],
    );
  }
}
