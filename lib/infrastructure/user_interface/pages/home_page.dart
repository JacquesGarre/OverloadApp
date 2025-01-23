import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_config.dart';
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
              TableColumnConfig(width: 64, text: "Set"),
              TableColumnConfig(text: "Kgs"),
              TableColumnConfig(text: "Reps"),
            ],
          ),
        ],
      ),
    );
  }
}
