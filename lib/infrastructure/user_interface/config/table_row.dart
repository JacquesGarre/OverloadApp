import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/domain/workout/set/metrics.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/set/set.dart';
import 'package:overload/infrastructure/user_interface/config/table_cell_value.dart';

class TableRow {
  final List<TableCellValue> cells;

  TableRow({required this.cells});

  static List<TableRow> fromSets(Sets sets) {
    List<TableRow> rows = [];
    for (Set set in sets.value()) {
      rows.add(fromSet(set));
    }
    return rows;
  }

  static TableRow fromSet(Set set) {
    List<TableCellValue> cells = [];
    cells.add(TableCellValue(value: set.index().value().toString()));
    for (Metric metric in set.metrics().value()) {
      cells.add(TableCellValue.fromMetric(metric));
    }
    return TableRow(cells: cells);
  }

  static TableRow fromSetIndexAndExercise(
      SetIndex lastIndex, Exercise exercise) {
    List<TableCellValue> cells = [];
    cells.add(TableCellValue(value: lastIndex.value().toString()));
    Metrics metrics = Metrics.fromExercise(exercise);
    for (Metric metric in metrics.value()) {
      cells.add(TableCellValue.fromMetric(metric));
    }
    return TableRow(cells: cells);
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
