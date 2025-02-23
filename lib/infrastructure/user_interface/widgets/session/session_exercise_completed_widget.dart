import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class SessionExerciseCompletedWidget extends StatelessWidget {
  final SessionExercise sessionExercise;

  const SessionExerciseCompletedWidget({
    super.key,
    required this.sessionExercise,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColorScheme.primary.withOpacity(0.5),
                      blurRadius: 200,
                      spreadRadius: 60,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.check,
                size: 100,
                color: AppColorScheme.onPrimary,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "${sessionExercise.workoutExercise().exercise().name().value()} done!",
            style: TextStyle(
              color: AppColorScheme.onPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: AppColorScheme.primary.withOpacity(0.7),
                  offset: const Offset(0, 0),
                ),
              ],
            ),
          ),
        ],
      )
          .animate()
          .scale(delay: 0.ms, duration: 300.ms)
          .fadeOut(delay: 1.seconds, duration: 500.ms),
    );
  }
}
