import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_config.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/table_column_widget.dart';

class TableWidget extends StatelessWidget {
  final double rowHeight;
  final List<TableColumnConfig> columns;

  const TableWidget(
      {super.key, required this.rowHeight, required this.columns});

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
        TableRow(
          children: <Widget>[
            TableCell(
              child: SizedBox(
                height: rowHeight,
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: false,
                    enabled: true,
                    enableSuggestions: false,
                    decoration: null,
                    controller: TextEditingController(),
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
              ),
            ),
            TableCell(
              child: SizedBox(
                height: rowHeight,
                child: Center(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
              ),
            ),
            TableCell(
              child: SizedBox(
                height: rowHeight,
                child: Center(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
