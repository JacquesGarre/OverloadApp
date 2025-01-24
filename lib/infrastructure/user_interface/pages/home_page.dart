import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_config.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_format.dart';
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
          TableWidget(
            rowHeight: 40,
            columns: [
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
            ],
            rows: const [
              ["1", "36.5", "12", "01:30", "02:45:12"],
              ["2", "36.5", "12", "01:30", "02:45:12"],
              ["3", "36.5", "12", "01:30", "02:45:12"],
              ["4", "36.5", "12", "01:30", "02:45:12"],
            ]
          ),
        ],
      ),
    );
  }
}
