import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/badge_widget.dart';

class UnitsBadgesWidget extends StatelessWidget {
  final Units units;

  const UnitsBadgesWidget({super.key, required this.units});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      runSpacing: 0.0,
      children: units.value().map((unit) {
        return BadgeWidget(text: unit.name());
      }).toList(),
    );
  }
}
