import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/set/metrics.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/set/set.dart';
import 'package:overload/infrastructure/user_interface/config/table_cell_type.dart';
import 'package:overload/infrastructure/user_interface/config/table_cell_value.dart';

class TableRow {

  final List<TableCellValue> cells;
  final bool checkable;

  TableRow({required this.cells, required this.checkable});

  static List<TableRow> fromSets(Sets sets, bool checkable, Sets? previousSets) {
    List<TableRow> rows = [];
    for (Set set in sets.value()) {
      Set? previousSet;
      if (previousSets != null) {
        previousSet = previousSets.findByIndex(set.index());
      }
      rows.add(fromSet(set, checkable, previousSet));
    }
    return rows;
  }

  bool isChecked() {
    if (!checkable) {
      return false;
    }
    for(TableCellValue cell in cells) {
      if (cell.isChecked()) {
        return true;
      }
    }
    return false;
  }

  static TableRow fromSet(Set set, bool checkable, Set? previousSet) {
    List<TableCellValue> cells = [];
    cells.add(
      TableCellValue(
        value: set.index().value().toString(),
        type: TableCellType.text,
      ),
    );
    for (Metric metric in set.metrics().value()) {
      Metric? previousMetric;
      if (previousSet != null) {
        previousMetric = previousSet.metrics().findByUnit(metric.unit());
      }
      cells.add(TableCellValue.fromMetric(metric, previousMetric));
    }
    if (checkable) {
      cells.add(TableCellValue.checkbox(set.isDone()));
    }
    return TableRow(cells: cells, checkable: checkable);
  }

  static TableRow fromSetIndexAndExercise(
    SetIndex lastIndex,
    Exercise exercise,
    bool checkable
  ) {
    List<TableCellValue> cells = [];
    cells.add(TableCellValue(value: lastIndex.value().toString(), type: TableCellType.text));
    Metrics metrics = Metrics.fromExercise(exercise);
    for (Metric metric in metrics.value()) {
      cells.add(TableCellValue.fromMetric(metric, null));
    }
    if (checkable) {
      cells.add(TableCellValue.checkbox(false));
    }
    return TableRow(cells: cells, checkable: checkable);
  }

  @override
  String toString() {
    String string = "";
    for (TableCellValue cell in cells) {
      string = "$string $cell";
    }
    return string;
  }
}
