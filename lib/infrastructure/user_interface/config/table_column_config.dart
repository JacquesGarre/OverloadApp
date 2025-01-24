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
}
