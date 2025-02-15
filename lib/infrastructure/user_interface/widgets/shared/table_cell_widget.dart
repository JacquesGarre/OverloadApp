import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:overload/infrastructure/user_interface/config/table_cell_type.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_format.dart';
import 'package:overload/infrastructure/user_interface/config/table_row.dart'
    as config;
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class TableCellWidget extends StatefulWidget {
  final double height;
  final bool readOnly;
  final bool canBeNegative;
  final String? value;
  final TableColumnFormat format;
  final String? placeholder;
  final TextStyle? style;
  final config.TableRow row;
  final int cellIndex;
  final Function(String value) onChanged;
  final TableCellType type;

  const TableCellWidget({
    super.key,
    required this.height,
    required this.readOnly,
    required this.format,
    required this.canBeNegative,
    required this.row,
    required this.cellIndex,
    required this.onChanged,
    required this.type,
    this.value,
    this.placeholder,
    this.style,
  });

  @override
  TableCellWidgetState createState() => TableCellWidgetState();
}

class TableCellWidgetState extends State<TableCellWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: widget.row.cells[widget.cellIndex].value);
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onChanged(widget.row.cells[widget.cellIndex].value ?? "");
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: SizedBox(
        height: widget.height,
        child: Center(
          child: widget.type == TableCellType.text
              ? TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: widget.readOnly,
                  enabled: !widget.readOnly,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(
                      color: AppColorScheme.onPrimary.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  focusNode: _focusNode,
                  controller: _controller,
                  style: widget.style ??
                      TextStyle(
                        color: AppColorScheme.onPrimary,
                        fontWeight: FontWeight.w400,
                      ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9\-\.:]'),
                    ),
                    _getInputFormatter(widget.format),
                  ],
                  onChanged: (value) {
                    final formattedValue = _formatInput(
                      value,
                      widget.format,
                      widget.canBeNegative,
                    );
                    _controller.value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                        offset: formattedValue.length,
                      ),
                    );
                    widget.row.cells[widget.cellIndex].value = formattedValue;
                  },
                )
              : Checkbox(
                  value: widget.row.cells[widget.cellIndex].value == "true",
                  onChanged: (bool? value) {
                    final formattedValue = value.toString();
                    widget.row.cells[widget.cellIndex].value = formattedValue;
                    widget.onChanged(formattedValue);
                  },
                ),
        ),
      ),
    );
  }

  TextInputFormatter _getInputFormatter(TableColumnFormat format) {
    switch (format) {
      case TableColumnFormat.double:
        return FilteringTextInputFormatter.allow(
          widget.canBeNegative ? RegExp(r'[0-9\.\-]') : RegExp(r'[0-9\.]'),
        );
      case TableColumnFormat.integer:
        return FilteringTextInputFormatter.allow(
          widget.canBeNegative ? RegExp(r'[0-9\-]') : RegExp(r'[0-9]'),
        );
      case TableColumnFormat.timeMinutesSeconds:
      case TableColumnFormat.timeHoursMinutesSeconds:
        return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
      default:
        return FilteringTextInputFormatter.digitsOnly;
    }
  }

  String _formatInput(
    String value,
    TableColumnFormat format,
    bool allowNegative,
  ) {
    switch (format) {
      case TableColumnFormat.double:
        return _formatDouble(value, allowNegative: allowNegative);
      case TableColumnFormat.integer:
        return _formatInteger(value, allowNegative: allowNegative);
      case TableColumnFormat.timeMinutesSeconds:
        return _formatTime(value, hasHours: false);
      case TableColumnFormat.timeHoursMinutesSeconds:
        return _formatTime(value, hasHours: true);
      default:
        return value;
    }
  }

  String _formatDouble(String value, {bool allowNegative = false}) {
    final doubleRegex = allowNegative
        ? RegExp(r'^-?\d*(\.\d{0,1})?$')
        : RegExp(r'^\d*(\.\d{0,1})?$');

    if (allowNegative && value == '-') {
      return value;
    }
    if (doubleRegex.hasMatch(value)) {
      return value;
    }
    if (value.contains('.')) {
      final parts = value.split('.');
      final integerPart = parts[0];
      final decimalPart = parts[1];
      final truncatedDecimal =
          decimalPart.isNotEmpty ? decimalPart.substring(0, 1) : '';
      final truncatedValue = '$integerPart.$truncatedDecimal';
      return truncatedValue;
    }
    double? parsedValue = double.tryParse(value);
    if (parsedValue != null) {
      return parsedValue.toStringAsFixed(1);
    }
    return '0.0';
  }

  String _formatInteger(String value, {bool allowNegative = false}) {
    final intRegex = RegExp(r'^\-?\d*');
    if (allowNegative && value.startsWith('-') && value.length == 1) {
      return value;
    }
    if (intRegex.hasMatch(value)) {
      return value;
    }
    return '0';
  }

  String _formatTime(String value, {bool hasHours = false}) {
    String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) {
      return hasHours ? '00:00:00' : '00:00';
    }
    final maxLength = hasHours ? 6 : 4;
    if (digitsOnly.length > maxLength) {
      digitsOnly = digitsOnly.substring(digitsOnly.length - maxLength);
    }
    digitsOnly = digitsOnly.padLeft(maxLength, '0');
    if (hasHours) {
      final hours = digitsOnly.substring(0, 2);
      final minutes = digitsOnly.substring(2, 4);
      final seconds = digitsOnly.substring(4, 6);
      return '$hours:$minutes:$seconds';
    } else {
      final minutes = digitsOnly.substring(0, 2);
      final seconds = digitsOnly.substring(2, 4);
      return '$minutes:$seconds';
    }
  }
}
