import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:number_selector/number_selector.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/helpers/first_where_or_null.dart';
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

  List<PlutoColumn> columns = <PlutoColumn>[];
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;

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
      for (Set set in widget.sets.value) {
        PlutoRow? existingRow =
            stateManager!.rows.firstWhereOrNull((PlutoRow row) {
          final setIndexValue =
              row.cells[SetsTableColumns.setIndexColumnField]?.value;
          return setIndexValue == set.index.value;
        });
        if (existingRow != null) {
          rowsToAdd.add(existingRow);
        } else {
          rowsToAdd.add(generateRowFromSet(set));
        }
      }
      stateManager!.removeRows(stateManager!.rows);
      stateManager!.appendRows(rowsToAdd);
      // for (var row in stateManager!.rows) {
      //   for (var cell in row.cells.values) {
      //     if (cell.value == 0) {
      //       cell.value = '';
      //     }
      //   }
      // }
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
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          SizedBox(
            height: stateManager != null
                ? (stateManager!.rows.length + 1) * rowHeight + 16
                : (widget.sets.count() + 1) * rowHeight,
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
                Logger().i("onChanged");
              },
              onLoaded: (PlutoGridOnLoadedEvent event) {
                event.stateManager.setAutoEditing(true);
                event.stateManager.addListener(() {
                  final currentCell = event.stateManager.currentCell;
                  if (event.stateManager.isEditing && currentCell != null) {
                    if (currentCell.value == 0 || currentCell.value == '0') {
                      currentCell.value =
                          ''; // Clear default value when editing
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
            padding: EdgeInsets.fromLTRB(6.0, 20.0, 5.0, 15.0),
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
                  onUpdate: (number) {
                    setState(() {
                      if (stateManager != null) {
                        int currentRowCount = stateManager!.rows.length;

                        if (number > currentRowCount) {
                          // Add rows
                          for (int i = currentRowCount + 1; i <= number; i++) {
                            stateManager!.appendRows([
                              PlutoRow(
                                cells: {
                                  SetsTableColumns.setIndexColumnField:
                                      PlutoCell(value: i),
                                  ...widget.exercise.units.value
                                      .asMap()
                                      .map((_, unit) => MapEntry(
                                            unit.name,
                                            PlutoCell(
                                                value:
                                                    ''), // Default empty values for new row
                                          )),
                                  if (widget.checkable)
                                    SetsTableColumns.checkboxColumnField:
                                        PlutoCell(value: ''),
                                },
                              ),
                            ]);
                          }
                        } else if (number < currentRowCount) {
                          // Remove rows
                          int rowsToRemove = currentRowCount - number;
                          List<PlutoRow> rowsToDelete = stateManager!.rows
                              .sublist(currentRowCount - rowsToRemove);
                          stateManager!.removeRows(rowsToDelete);
                        }

                        stateManager!
                            .notifyListeners(); // Notify the grid to update
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
