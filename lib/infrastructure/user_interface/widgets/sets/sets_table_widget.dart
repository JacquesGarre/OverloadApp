import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:number_selector/number_selector.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/sets/sets_table_columns.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:overload/domain/workout/set/set.dart';

class SetsTableWidget extends StatefulWidget {
  final Exercise exercise;
  final Sets sets;
  final bool checkable;
  final bool setsNumberSelector;
  final bool readonly;
  final void Function(Sets updatedSets) onSetsUpdated;

  const SetsTableWidget({
    super.key,
    required this.exercise,
    required this.sets,
    required this.checkable,
    required this.setsNumberSelector,
    required this.onSetsUpdated,
    required this.readonly,
  });

  @override
  State<SetsTableWidget> createState() => _SetsTableWidgetState();
}

class _SetsTableWidgetState extends State<SetsTableWidget> {
  static const double rowHeight = 35;
  late Sets sets;
  late List<PlutoColumn> columns;
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;

  @override
  void initState() {
    super.initState();
    sets = widget.sets.clone();
    _initializeColumns();
    _initializeRows();
  }

  @override
  void didUpdateWidget(SetsTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.exercise != oldWidget.exercise ||
        widget.sets != oldWidget.sets) {
      sets = widget.sets.clone();
      _initializeColumns();
      _initializeRows();
    }
  }

  void _initializeColumns() {
    columns = [
      SetsTableColumns.setIndexColumn(),
      ...widget.exercise.units().value().map(
            (unit) => SetsTableColumns.unitColumn(unit, widget.readonly),
          ),
      if (widget.checkable) SetsTableColumns.checkboxColumn(),
    ];
  }

  void _initializeRows() {
    rows = sets.value().map(_generateRowFromSet).toList();
  }

  PlutoRow _generateRowFromSet(Set set) {
    final cells = {
      SetsTableColumns.setIndexColumnField:
          PlutoCell(value: set.index().value()),
      for (var unit in widget.exercise.units().value())
        unit.name(): PlutoCell(value: set.metrics().findByUnit(unit)?.value()),
      if (widget.checkable)
        SetsTableColumns.checkboxColumnField: PlutoCell(value: ''),
    };
    return PlutoRow(cells: cells);
  }

  void _updateSet(int rowIdx, int columnIdx, num value) {
    final setIndex = SetIndex(value: rowIdx + 1);
    final unit = widget.exercise.units().value()[columnIdx - 1];
    final metric = Metric(value: value, unit: unit);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          sets = sets.updateSet(setIndex, metric);
          widget.onSetsUpdated(sets);
          _initializeRows();
        });
      }
    });
  }

  void _generateSets(int number) {
    setState(() {
      if (number > sets.count()) {
        sets = sets.addSetFromExercise(widget.exercise);
      } else if (number < sets.count()) {
        sets = sets.removeLastSet();
      }
      widget.onSetsUpdated(sets); // TODO: Fix this, this is closing the keyboard...
      _initializeRows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          SizedBox(
            height: (sets.count() + 1) * rowHeight,
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              configuration: _gridConfiguration(),
              mode: widget.readonly
                  ? PlutoGridMode.selectWithOneTap
                  : PlutoGridMode.normal,
              onChanged: (event) => _updateSet(
                event.rowIdx,
                event.columnIdx,
                event.value,
              ), 
              onLoaded: (event) {
                if (!mounted) return;
                event.stateManager.setAutoEditing(true);
                event.stateManager.addListener(() {
                  if (!mounted) return;
                  final currentCell = event.stateManager.currentCell;
                  if (event.stateManager.isEditing && currentCell != null) {
                    if (currentCell.value == 0 || currentCell.value == '0') {
                      currentCell.value = '';
                      event.stateManager.notifyListeners();
                    }
                  }
                });
                stateManager = event.stateManager;
                _initializeRows();
              },
            ),
          ),
          if (widget.setsNumberSelector)
            Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 10.0, 5.0, 15.0),
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
                    current: stateManager != null
                        ? stateManager!.rows.length
                        : widget.sets.count(),
                    min: 1,
                    max: 30,
                    onUpdate: _generateSets,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  PlutoGridConfiguration _gridConfiguration() {
    return PlutoGridConfiguration(
      columnSize: const PlutoGridColumnSizeConfig(
        resizeMode: PlutoResizeMode.none,
        autoSizeMode: PlutoAutoSizeMode.scale,
      ),
      style: PlutoGridStyleConfig(
        columnHeight: rowHeight,
        rowHeight: rowHeight - 4,
        checkedColor: AppColorScheme.primary,
        gridBackgroundColor: Colors.transparent,
        rowColor: AppColorScheme.lightBackground,
        enableColumnBorderVertical: false,
        enableColumnBorderHorizontal: false,
        enableCellBorderHorizontal: false,
        enableCellBorderVertical: false,
        gridBorderColor: Colors.transparent,
        activatedColor: Colors.transparent,
        cellColorInEditState: Colors.transparent,
        cellColorInReadOnlyState: Colors.transparent,
        inactivatedBorderColor: Colors.transparent,
        evenRowColor: Colors.transparent,
        oddRowColor: Colors.transparent,
        columnTextStyle: const TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        cellTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        activatedBorderColor: Colors.transparent,
        gridBorderRadius: BorderRadius.circular(5.0),
        defaultColumnTitlePadding: const EdgeInsets.fromLTRB(
          5.0,
          2.0,
          5.0,
          2.0,
        ),
        defaultCellPadding: const EdgeInsets.fromLTRB(
          5.0,
          2.0,
          5.0,
          2.0,
        ),
      ),
    );
  }
}
