import 'package:overload/domain/workout/set/metric.dart';
import 'package:overload/infrastructure/user_interface/config/table_cell_type.dart';

class TableCellValue {
  
  String? value;
  String? placeholder;
  TableCellType type;

  TableCellValue({this.value, this.placeholder, required this.type});

  static TableCellValue fromMetric(Metric metric) {
    return TableCellValue(
      value: metric.value()?.toString(),
      placeholder: metric.value() != null ? metric.value().toString() : metric.defaultValue().toString(),
      type: TableCellType.text
    );
  }

  static TableCellValue checkbox(bool checked) {
    return TableCellValue(
      value: checked ? "true" : "false",
      placeholder: "",
      type: TableCellType.checkbox
    );
  }

  @override 
  String toString() {
    return "value: $value, placeholder: $placeholder";
  }
}
