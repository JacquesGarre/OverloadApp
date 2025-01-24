import 'package:flutter/material.dart';
import 'package:number_selector/number_selector.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_config.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/table_widget.dart';

class SetsTableWidget extends StatefulWidget {
  final Exercise exercise;
  final Sets sets;
  final bool checkable;
  final bool setsNumberSelector;
  final bool readonly;
  final void Function(Sets updatedSets) onSetsUpdated;

  const SetsTableWidget({
    super.key,
    required this.exercise,
    required this.sets,
    required this.checkable,
    required this.setsNumberSelector,
    required this.onSetsUpdated,
    required this.readonly,
  });

  @override
  State<SetsTableWidget> createState() => _SetsTableWidgetState();
}

class _SetsTableWidgetState extends State<SetsTableWidget> {
  
  static const double rowHeight = 35;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          TableWidget(
            rowHeight: rowHeight,
            columns: TableColumnConfig.fromExercise(widget.exercise),
            rows: [],
          ),
          if (widget.setsNumberSelector)
            Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 10.0, 5.0, 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberSelector.plain(
                    width: 150,
                    height: 40,
                    iconColor: AppColorScheme.primary,
                    borderRadius: 5.0,
                    backgroundColor: AppColorScheme.lightBackground,
                    borderColor: Colors.transparent,
                    showMinMax: false,
                    showSuffix: false,
                    hasDividers: false,
                    hasBorder: true,
                    current: widget.sets.count(),
                    min: 1,
                    max: 30,
                    onUpdate: (int value) {

                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
