import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/unit.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class UnitBadgeWidget extends StatelessWidget {
  final Unit unit;

  const UnitBadgeWidget({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 0.0,
      ),
      label: Text(
        unit.name(),
        style: TextStyle(
          color: AppColorScheme.onSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: AppColorScheme.secondary,
      side: BorderSide.none,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
