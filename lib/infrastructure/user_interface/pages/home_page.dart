import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/config/table_cell_value.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_config.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_format.dart';
import 'package:overload/infrastructure/user_interface/config/table_row.dart'
    as config;
import 'package:overload/infrastructure/user_interface/widgets/shared/table_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String title = 'Home';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TableWidget(rowHeight: 40, columns: [
            TableColumnConfig(
              width: 64,
              text: "Set",
              format: TableColumnFormat.integer,
              canBeNegative: false,
              readOnly: true,
            ),
            TableColumnConfig(
              text: "Kgs",
              format: TableColumnFormat.double,
              canBeNegative: false,
              readOnly: false,
            ),
            TableColumnConfig(
              text: "Reps",
              format: TableColumnFormat.integer,
              canBeNegative: false,
              readOnly: false,
            ),
            TableColumnConfig(
              text: "mm:ss",
              format: TableColumnFormat.timeMinutesSeconds,
              canBeNegative: false,
              readOnly: false,
            ),
            TableColumnConfig(
              text: "Time",
              format: TableColumnFormat.timeHoursMinutesSeconds,
              canBeNegative: false,
              readOnly: false,
            ),
          ], rows: [
            config.TableRow(cells: [
              TableCellValue(value: "1"),
              TableCellValue(value: "36.5", placeholder: "32"),
              TableCellValue(value: "10", placeholder: "12"),
              TableCellValue(value: "01:30", placeholder: "01:30"),
              TableCellValue(value: "02:00:00", placeholder: "02:00:00")
            ]),
            config.TableRow(cells: [
              TableCellValue(value: "2"),
              TableCellValue(placeholder: "32"),
              TableCellValue(placeholder: "12"),
              TableCellValue(placeholder: "01:30"),
              TableCellValue(placeholder: "02:00:00")
            ]),
            config.TableRow(cells: [
              TableCellValue(value: "3"),
              TableCellValue(),
              TableCellValue(),
              TableCellValue(),
              TableCellValue()
            ]),
          ]),
        ],
      ),
    );
  }
}
