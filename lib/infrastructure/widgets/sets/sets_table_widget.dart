import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:number_selector/number_selector.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/widgets/sets/sets_table_columns.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:overload/domain/workout/set/set.dart';

class SetsTableWidget extends StatefulWidget {
  final Exercise exercise;
  final Sets sets;
  final bool checkable;

  const SetsTableWidget({
    super.key,
    required this.exercise,
    required this.sets,
    required this.checkable,
  });

  @override
  State<SetsTableWidget> createState() => _SetsTableWidgetState();
}

class _SetsTableWidgetState extends State<SetsTableWidget> {
  static double rowHeight = 35;
  Sets? sets;
  List<PlutoColumn> columns = <PlutoColumn>[];
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;

  @override
  void initState() {
    super.initState();
    sets = widget.sets;
    generateColumns();
    generateRows();
  }

  @override
  void didUpdateWidget(covariant SetsTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.exercise != oldWidget.exercise ||
        widget.sets != oldWidget.sets) {
      generateColumns();
      generateRows();
      setState(() {});
    }
  }

  void updateSet(int rowIdx, int columnIdx, num value) {
    SetIndex setIndex = SetIndex(value: rowIdx+1);
    Unit unit = widget.exercise.units.value[columnIdx-1];
    Metric metric = Metric(value: value, unit: unit);
    setState(() {
      sets = sets!.updateSet(setIndex, metric);
      Logger().i(sets);
      Logger().i(sets!.count());
    });
    generateRows();
  }

  void generateSets(int number) {
    if (number > sets!.count()) {
      addSet();
    }
    if (number < sets!.count()) {
      removeSet();
    }
  }

  void addSet() {
    setState(() {
      sets = sets!.addSetFromExercise(widget.exercise);
    });
    generateRows();
  }

  void removeSet() {
    setState(() {
      sets = sets!.removeLastSet();
    });
    generateRows();
  }

  void generateColumns() {
    columns.clear();
    columns.add(SetsTableColumns.setIndexColumn());
    for (Unit unit in widget.exercise.units.value) {
      columns.add(SetsTableColumns.unitColumn(unit));
    }
    if (widget.checkable) {
      columns.add(SetsTableColumns.checkboxColumn());
    }
  }

  void generateRows() {
    if (stateManager != null) {
      List<PlutoRow> rowsToAdd = [];
      for (Set set in sets!.value) {
        rowsToAdd.add(generateRowFromSet(set));
      }
      stateManager!.removeRows(stateManager!.rows);
      stateManager!.appendRows(rowsToAdd);
      stateManager!.notifyListeners();
    }
  }

  PlutoRow generateRowFromSet(Set set) {
    Map<String, PlutoCell> cells = {
      SetsTableColumns.setIndexColumnField: PlutoCell(value: set.index.value),
      SetsTableColumns.checkboxColumnField: PlutoCell(value: ''),
    };
    for (Unit unit in widget.exercise.units.value) {
      Metric? metric = set.metrics.findByUnit(unit);
      cells[unit.name] = PlutoCell(value: metric?.value);
    }
    return PlutoRow(cells: cells);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          SizedBox(
            height: (sets!.count() + 1) * rowHeight,
            child: PlutoGrid(
              configuration: PlutoGridConfiguration(
                enterKeyAction: PlutoGridEnterKeyAction.toggleEditing,
                columnSize: const PlutoGridColumnSizeConfig(
                  resizeMode: PlutoResizeMode.none,
                  autoSizeMode: PlutoAutoSizeMode.scale,
                ),
                style: PlutoGridStyleConfig(
                  columnHeight: rowHeight,
                  rowHeight: rowHeight,
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
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
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
              ),
              columns: columns,
              rows: rows,
              mode: PlutoGridMode.normal,
              onSelected: (PlutoGridOnSelectedEvent event) {
                Logger().i("onSelected");
              },
              onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {
                Logger().i("onRowDoubleTap");
              },
              onRowChecked: (PlutoGridOnRowCheckedEvent event) {
                Logger().i("onRowChecked");
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                updateSet(event.rowIdx, event.columnIdx, event.value);
              },
              onLoaded: (PlutoGridOnLoadedEvent event) {
                event.stateManager.setAutoEditing(true);
                event.stateManager.addListener(() {
                  final currentCell = event.stateManager.currentCell;
                  if (event.stateManager.isEditing && currentCell != null) {
                    if (currentCell.value == 0 || currentCell.value == '0') {
                      currentCell.value = '';
                      event.stateManager.notifyListeners();
                    }
                  }
                });
                event.stateManager.notifyListeners();
                stateManager = event.stateManager;
                generateRows();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 20.0, 5.0, 15.0),
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
                  onUpdate: generateSets,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
