import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exception/unknown_exercise_unit_type_exception.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/domain/exercise/unit_type.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';
import 'package:pluto_grid/pluto_grid.dart';

class SetsTableColumns {
  static String setIndexColumnTitle = 'Set';
  static String setIndexColumnField = 'setIndex';
  static String checkboxColumnTitle = '✓';
  static String checkboxColumnField = 'checked';

  static PlutoColumn setIndexColumn() {
    return PlutoColumn(
      title: setIndexColumnTitle,
      field: setIndexColumnField,
      type: PlutoColumnType.number(),
      textAlign: PlutoColumnTextAlign.start,
      titleTextAlign: PlutoColumnTextAlign.start,
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      width: 5.0,
      readOnly: true,
      renderer: (rendererContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(1.0, 0.0, 0.0, 0.0),
          child: Text(
            rendererContext.cell.value.toString(),
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }

  static PlutoColumn unitColumn(Unit unit, bool readOnly) {
    switch (unit.type()) {
      case UnitType.integer:
      case UnitType.double:
        return SetsTableColumns.numberColumn(unit, readOnly);
      default:
        throw UnknownExerciseUnitTypeException();
    }
  }

  static PlutoColumn checkboxColumn() {
    return PlutoColumn(
      width: 5.0,
      enableSetColumnsMenuItem: false,
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: checkboxColumnTitle,
      field: checkboxColumnField,
      type: PlutoColumnType.text(),
      renderer: (rendererContext) {
        bool isChecked = rendererContext.cell.value == 'checked';
        return Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            if (value != null) {
              rendererContext.stateManager.changeCellValue(
                rendererContext.cell,
                value ? 'checked' : '',
              );
            }
          },
          activeColor: AppColorScheme.primary,
          checkColor: Colors.white,
          side: BorderSide(color: AppColorScheme.primary, width: 2),
        );
      },
    );
  }

  static PlutoColumn numberColumn(Unit unit, bool readOnly) {
    return PlutoColumn(
      width: 5.0,
      enableSetColumnsMenuItem: false,
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      readOnly: readOnly,
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: unit.name(),
      field: unit.name(),
      type: PlutoColumnType.number(
        defaultValue: null,
        negative: unit.canBeNegative(),
        format: unit.type().format(),
        applyFormatOnInit: true,
      ),
      applyFormatterInEditing: true,
      formatter: (dynamic value) {
        return value.toString().replaceFirst(RegExp(r'^0+(?!$)'), '');
      },
    );
  }
}
