import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

Future<Duration?> showRestTimePicker(
    BuildContext context, Duration initialDuration) async {
  Duration selectedDuration = initialDuration; // Default duration

  return await showCupertinoModalPopup<Duration>(
    context: context,
    builder: (_) => Container(
      height: 250,
      color: AppColorScheme.lightBackground,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: CupertinoTimerPicker(
              backgroundColor: AppColorScheme.lightBackground,
              mode: CupertinoTimerPickerMode.ms, 
              initialTimerDuration: initialDuration,
              onTimerDurationChanged: (Duration newDuration) {
                selectedDuration = newDuration;
              },
            ),
          ),
          TextButton(
            child: const Text("Done"),
            onPressed: () => Navigator.pop(context, selectedDuration),
          ),
        ],
      ),
    ),
  );
}
