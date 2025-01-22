import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/goal.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/sets/sets_table_widget.dart';

class GoalWidget extends StatefulWidget {
  final int index;
  final Goal goal;
  final Exercise exercise;
  final Function(int index) onRemove;
  final Function(int index, Sets sets) onUpdate;

  const GoalWidget({
    super.key,
    required this.index,
    required this.goal,
    required this.exercise,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
      child: Card(
        key: ValueKey("goal_${widget.goal.hashCode}"),
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
                      "Objective ${widget.index}",
                      style: TextStyle(
                        color: AppColorScheme.onLightBackground,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.onRemove(widget.index);
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
                sets: widget.goal.sets(),
                checkable: false,
                setsNumberSelector: true,
                readonly: false,
                onSetsUpdated: (updatedSets) {
                  widget.onUpdate(
                    widget.index,
                    updatedSets,
                  ); // TODO: This is closing the keyboard
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
