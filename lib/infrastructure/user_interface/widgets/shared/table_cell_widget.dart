import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:overload/infrastructure/user_interface/config/table_column_format.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';



class TableCellWidget extends StatelessWidget {
  final double height;
  final bool readOnly;
  final bool canBeNegative;
  final String? value;
  final TableColumnFormat format;

  const TableCellWidget({
    super.key,
    required this.height,
    required this.readOnly,
    required this.format,
    required this.canBeNegative,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: value);

    return TableCell(
      child: SizedBox(
        height: height,
        child: Center(
          child: TextFormField(
            keyboardType: TextInputType.number,
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            readOnly: readOnly,
            enabled: !readOnly,
            enableSuggestions: false,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            controller: controller,
            style: TextStyle(
              color: AppColorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9\-\.:]'),
              ),
              _getInputFormatter(format),
            ],
            onChanged: (value) {
              final formattedValue = _formatInput(value, format, canBeNegative);
              Logger().e(formattedValue);
              if (formattedValue != value) {
                controller.value = TextEditingValue(
                  text: formattedValue,
                  selection: TextSelection.collapsed(
                    offset: formattedValue.length,
                  ),
                );
              }
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
          canBeNegative ? RegExp(r'[0-9\.\-]') : RegExp(r'[0-9\.]'),
        );
      case TableColumnFormat.integer:
        return FilteringTextInputFormatter.allow(
          canBeNegative ? RegExp(r'[0-9\-]') : RegExp(r'[0-9]'),
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
        ? RegExp(r'^-?\d*(\.\d{0,2})?$')
        : RegExp(r'^\d*(\.\d{0,2})?$');
    if (allowNegative && value == '-') {
      return value;
    }
    if (doubleRegex.hasMatch(value)) {
      return value;
    }
    double? parsedValue = double.tryParse(value);
    if (parsedValue != null) {
      return parsedValue.toStringAsFixed(2);
    }
    return '0.00';
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
    // Remove non-digit characters
    String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Handle empty input by returning the default time format
    if (digitsOnly.isEmpty) {
      return hasHours ? '00:00:00' : '00:00';
    }

    // Ensure the input has a maximum length (4 for MM:SS, 6 for HH:MM:SS)
    final maxLength = hasHours ? 6 : 4;
    if (digitsOnly.length > maxLength) {
      digitsOnly = digitsOnly.substring(digitsOnly.length - maxLength);
    }

    // Pad the input with leading zeros to maintain the proper format
    digitsOnly = digitsOnly.padLeft(maxLength, '0');

    // Format the string based on whether hours are included
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
