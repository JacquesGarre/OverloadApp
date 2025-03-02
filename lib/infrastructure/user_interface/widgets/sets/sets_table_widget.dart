import 'package:flutter/material.dart';
import 'package:number_selector/number_selector.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/set/set.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_config.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/table_widget.dart';
import 'package:overload/infrastructure/user_interface/config/table_row.dart'
    as config;

class SetsTableWidget extends StatefulWidget {
  final Exercise exercise;
  final Sets sets;
  final bool checkable;
  final bool setsNumberSelector;
  final bool readonly;
  final void Function(Sets updatedSets) onSetsUpdated;
  final void Function(SessionExercise updatedSessionExercise)? onSetDone;
  final Sets? previousSets;
  final SessionExercise? sessionExercise;

  const SetsTableWidget({
    super.key,
    required this.exercise,
    required this.sets,
    required this.checkable,
    required this.setsNumberSelector,
    required this.onSetsUpdated,
    required this.readonly,
    this.previousSets,
    this.onSetDone,
    this.sessionExercise,
  });

  @override
  State<SetsTableWidget> createState() => _SetsTableWidgetState();
}

class _SetsTableWidgetState extends State<SetsTableWidget> {
  static const double rowHeight = 35;
  late Sets sets;
  List<config.TableRow> rows = [];

  @override
  void initState() {
    super.initState();
    sets = widget.sets;
    rows =
        config.TableRow.fromSets(sets, widget.checkable, widget.previousSets);
  }

  _updateRowsCount(int value) {
    if (value > rows.length) {
      SetIndex lastIndex = SetIndex.nextFromSetIndex(sets.lastSet()?.index());
      Set newSet = Set.fromSetIndexAndExercise(lastIndex, widget.exercise);

      Set? previousSet;
      if (widget.previousSets != null) {
        previousSet = widget.previousSets!.findByIndex(newSet.index());
      }
      setState(() {
        sets = sets.add(newSet);
        rows.add(
            config.TableRow.fromSet(newSet, widget.checkable, previousSet));
        widget.onSetsUpdated(sets);
      });
    }
    if (value < rows.length) {
      setState(() {
        sets = sets.removeLastSet();
        rows.removeLast();
        widget.onSetsUpdated(sets);
      });
    }
  }

  _onChange(int rowIndex, int cellIndex, String value) {
    config.TableRow row = rows[rowIndex];
    int setIndexValue = int.tryParse(row.cells[0].value ?? '') ?? 0;
    setState(() {
      Set? setBefore = sets.findByIndex(SetIndex(value: setIndexValue));
      sets = sets.update(setIndexValue, cellIndex, value);
      widget.onSetsUpdated(sets);
      Set? setAfter = sets.findByIndex(SetIndex(value: setIndexValue));
      if (setBefore != null &&
          !setBefore.isDone() &&
          setAfter != null &&
          setAfter.isDone() &&
          widget.onSetDone != null &&
          widget.sessionExercise != null) {
        widget.onSetDone!(widget.sessionExercise!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          TableWidget(
            rowHeight: rowHeight,
            columns: TableColumnConfig.fromExercise(
              widget.exercise,
              widget.checkable,
            ),
            rows: rows,
            onChanged: _onChange,
          ),
          if (widget.setsNumberSelector)
            const SizedBox(
              height: 6.0,
            ),
          if (widget.setsNumberSelector)
            Divider(
              color: AppColorScheme.onLightBackground,
            ),
          if (widget.setsNumberSelector)
            Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 0.0, 5.0, 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberSelector.plain(
                    width: 150,
                    height: 40,
                    iconColor: AppColorScheme.primary,
                    borderRadius: 5.0,
                    backgroundColor: AppColorScheme.lightBackground,
                    borderColor: Colors.transparent,
                    showMinMax: false,
                    showSuffix: false,
                    hasDividers: false,
                    hasBorder: true,
                    current: widget.sets.count(),
                    min: 1,
                    max: 30,
                    onUpdate: _updateRowsCount,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
