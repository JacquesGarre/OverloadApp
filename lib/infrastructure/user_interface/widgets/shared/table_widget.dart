import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_config.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/table_cell_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/table_column_widget.dart';

class TableWidget extends StatelessWidget {
  final double rowHeight;
  final List<TableColumnConfig> columns;
  final List<List<dynamic>> rows;

  const TableWidget({
    super.key,
    required this.rowHeight,
    required this.columns,
    required this.rows,
  });

  Map<int, TableColumnWidth> _columnsWidths() {
    Map<int, TableColumnWidth> columnsWidth = {};
    int i = 0;
    for (TableColumnConfig config in columns) {
      columnsWidth[i] = config.width != null
          ? FixedColumnWidth(config.width!)
          : const FlexColumnWidth();
      i++;
    }
    return columnsWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(), // TODO: toremove
      columnWidths: _columnsWidths(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            ...columns.map((column) {
              return TableColumnWidget(
                rowHeight: rowHeight,
                text: column.text,
              );
            })
          ],
        ),
        ...rows.map((row) {
          return TableRow(children: <Widget>[
            ...row.asMap().entries.map((entry) {
              int index = entry.key;
              String value = entry.value;
              return TableCellWidget(
                height: rowHeight,
                readOnly: columns[index].readOnly,
                value: value,
                format: columns[index].format,
                canBeNegative: columns[index].canBeNegative,
              );
            }),
          ]);
        }),
      ],
    );
  }
}
