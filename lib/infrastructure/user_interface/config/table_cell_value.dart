import 'package:overload/domain/workout/set/metric.dart';

class TableCellValue {
  
  String? value;
  String? placeholder;

  TableCellValue({this.value, this.placeholder});

  static TableCellValue fromMetric(Metric metric) {
    return TableCellValue(
      value: metric.value()?.toString(),
      placeholder: metric.value() != null ? metric.value().toString() : metric.defaultValue().toString()
    );
  }
}
