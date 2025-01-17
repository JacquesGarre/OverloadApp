import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
      child: SizedBox(
        height: (widget.sets.count() + 1) * 50,
        child: PlutoGrid(
          configuration: PlutoGridConfiguration(
            enterKeyAction: PlutoGridEnterKeyAction.toggleEditing,
            columnSize: const PlutoGridColumnSizeConfig(
              resizeMode: PlutoResizeMode.none,
              autoSizeMode: PlutoAutoSizeMode.scale,
            ),
            style: PlutoGridStyleConfig(
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
                5.0,
                5.0,
                5.0,
              ),
              defaultCellPadding: const EdgeInsets.fromLTRB(
                5.0,
                5.0,
                5.0,
                5.0,
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
                  currentCell.value = ''; // Clear default value when editing
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
    );
  }
}
