import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

Future<bool> showDeleteWorkoutExerciseConfirmationModal({
  required BuildContext context,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Remove workout exercise",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              )),
          content: Text(
            "Are you sure you want to remove this exercise? This action cannot be undone.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColorScheme.onLightBackground,
              fontSize: 13.0,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      AppColorScheme.error,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      AppColorScheme.onPrimary,
                    ),
                  ),
                  onPressed: () => Navigator.pop(
                    context,
                    true,
                  ),
                  child: const Text("Remove"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      AppColorScheme.lightBackground,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      AppColorScheme.primary,
                    ),
                  ),
                  onPressed: () => Navigator.pop(
                    context,
                    false,
                  ),
                  child: const Text("Cancel"),
                ),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
