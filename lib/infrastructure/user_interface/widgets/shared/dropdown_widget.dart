import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/theme/app_theme.dart';

class DropdownWidget<T> extends StatelessWidget {
  final bool readonly;
  final List<T> items;
  final T? initialItem;
  final Future<List<T>> Function(String) searchFunction;
  final Function(T?)? onChanged;
  final String placeholder;

  const DropdownWidget({
    super.key,
    required this.readonly,
    required this.items,
    required this.searchFunction,
    required this.placeholder,
    this.initialItem,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorScheme.lightBackground,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: AppTheme.theme.inputDecorationTheme.border?.borderSide.color ??
              Colors.white,
          width: 1,
        ),
      ),
      child: CustomDropdown<T>.searchRequest(
        disabledDecoration: CustomDropdownDisabledDecoration(
          suffixIcon: null,
          fillColor: AppColorScheme.lightBackground,
          headerStyle: TextStyle(
            fontSize: 16.0,
            color: AppColorScheme.onLightBackground,
          ),
          hintStyle: TextStyle(
            color: AppColorScheme.onLightBackground,
          ),
        ),
        enabled: readonly,
        initialItem: initialItem,
        decoration: CustomDropdownDecoration(
          closedFillColor: AppColorScheme.lightBackground,
          expandedFillColor: AppColorScheme.lightBackground,
          hintStyle: TextStyle(
            color: AppTheme.theme.inputDecorationTheme.hintStyle?.color,
          ),
          listItemDecoration: ListItemDecoration(
            selectedColor: AppColorScheme.lightBackground,
            splashColor: AppColorScheme.lightBackground,
            highlightColor: AppColorScheme.lightBackground,
          ),
          searchFieldDecoration: SearchFieldDecoration(
            fillColor: AppColorScheme.lightBackground,
            textStyle: TextStyle(
              color: AppColorScheme.onLightBackground,
              fontSize: 14.0,
            ),
            hintStyle: AppTheme.theme.inputDecorationTheme.hintStyle,
          ),
          listItemStyle: const TextStyle(
            fontSize: 14.0,
          ),
        ),
        futureRequest: searchFunction,
        hintText: placeholder,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
