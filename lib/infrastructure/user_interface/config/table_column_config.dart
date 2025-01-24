import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/unit_type.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_format.dart';

class TableColumnConfig {
  final double? width;
  final String text;
  final TableColumnFormat format;
  final bool canBeNegative;
  final bool readOnly;

  TableColumnConfig({
    required this.text,
    required this.format,
    required this.canBeNegative,
    required this.readOnly,
    this.width,
  });

  static List<TableColumnConfig> fromExercise(Exercise exercise) {
    List<TableColumnConfig> columns = [];
    columns.add(setIndexColumn());
    for (Unit unit in exercise.units().value()) {
      columns.add(fromUnit(unit));
    }
    return columns;
  }

  static TableColumnConfig setIndexColumn() {
    return TableColumnConfig(
      text: "Set",
      format: TableColumnFormat.integer,
      readOnly: true,
      canBeNegative: false,
    );
  }

  static TableColumnConfig fromUnit(Unit unit) {
    TableColumnFormat format;
    switch (unit.type()) {
      case UnitType.double:
        format = TableColumnFormat.double;
        break;
      case UnitType.integer:
        format = TableColumnFormat.integer;
        break;
      default:
        throw Exception("Invalid unit type for a table column");
    }
    return TableColumnConfig(
      text: unit.name(),
      format: format,
      readOnly: false,
      canBeNegative: unit.canBeNegative(),
    );
  }
}
