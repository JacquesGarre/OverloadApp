import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_config.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/table_cell_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/table_column_widget.dart';
import 'package:overload/infrastructure/user_interface/config/table_row.dart'
    as config;

class TableWidget extends StatelessWidget {
  final double rowHeight;
  final List<TableColumnConfig> columns;
  final List<config.TableRow> rows;
  final Function(int rowIndex, int cellIndex, String value) onChanged;

  const TableWidget({
    super.key,
    required this.rowHeight,
    required this.columns,
    required this.rows,
    required this.onChanged,
  });

  Map<int, TableColumnWidth> _columnsWidths() {
    Map<int, TableColumnWidth> columnsWidth = {};
    int i = 0;
    for (TableColumnConfig config in columns) {
      columnsWidth[i] = config.width != null
          ? FixedColumnWidth(config.width!)
          : const FlexColumnWidth(1);
      i++;
    }
    return columnsWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
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
        ...rows.asMap().entries.map((entry) {
          int rowIndex = entry.key;
          config.TableRow row = entry.value;
          return TableRow(
            children: <Widget>[
            ...row.cells.asMap().entries.map((entry) {
              int cellIndex = entry.key;
              String? value = entry.value.value;
              String? placeholder = entry.value.placeholder;
              return TableCellWidget(
                height: rowHeight,
                readOnly: columns[cellIndex].readOnly,
                value: value,
                placeholder: placeholder,
                format: columns[cellIndex].format,
                canBeNegative: columns[cellIndex].canBeNegative,
                row: row,
                type: entry.value.type,
                onChanged: (String value) {
                  onChanged(rowIndex, cellIndex, value);
                },
                cellIndex: cellIndex,
              );
            }),
          ]);
        }),
      ],
    );
  }
}
