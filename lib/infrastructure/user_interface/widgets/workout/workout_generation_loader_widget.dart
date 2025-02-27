import 'dart:async';
import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class WorkoutGenerationLoaderWidget extends StatefulWidget {

  const WorkoutGenerationLoaderWidget({super.key});

  @override
  WorkoutGenerationLoaderWidgetState createState() => WorkoutGenerationLoaderWidgetState();
}

class WorkoutGenerationLoaderWidgetState extends State<WorkoutGenerationLoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;

  int messageIndex = 0;
  bool showMessage = true;

  final List<String> messages = [
    "Generating your personalized workouts...",
    "This will take approximately 30 seconds ⏳",
    "Why not warm-up while you wait? 🔥",
    "Mixing strength, endurance, and fun 💪",
    "You're about to overload your limits! 🚀",
    "Almost there! Get ready to crush it! 🏋️",
    "Designing your perfect routine... 💪",
    "Syncing beats with your gains... 🎵",
    "Analyzing your goals... 📊",
    "Almost ready to lift! 🏋️‍♀️",
    "Just a few more reps... 🥵",
    "Overloading your potential! 🚀",
  ];

  @override
  void initState() {
    super.initState();

    // Dumbbell grow-shrink animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1.2,
    )..repeat(reverse: true);

    // Message cycling logic
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (messageIndex < messages.length - 1) {
        if (!mounted) return;
        setState(() {
          showMessage = false;
        });
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            messageIndex++;
            showMessage = true;
          });
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _controller,
            child: Icon(
              Icons.emoji_events,
              size: 50,
              color: AppColorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: showMessage ? 1.0 : 0.0,
            child: Text(
              messages[messageIndex],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
