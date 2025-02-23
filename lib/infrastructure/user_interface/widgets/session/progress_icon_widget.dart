import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class ProgressIconWidget extends StatelessWidget {
  final num currentValue;
  final num previousValue;

  const ProgressIconWidget({
    super.key,
    required this.currentValue,
    required this.previousValue,
  });

  @override
  Widget build(BuildContext context) {
    if (currentValue == previousValue) {
      return const Text("");
    }
    String icon = MaterialSymbols.arrow_drop_up;
    Color color = AppColorScheme.success;
    if (currentValue < previousValue) {
      icon = MaterialSymbols.arrow_drop_down;
      color = AppColorScheme.error;
    }
    return Iconify(
      icon, 
      color: color,
      size: 20,
    );
  }
}
