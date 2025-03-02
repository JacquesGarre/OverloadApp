import 'dart:async';

import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class RestCountdownSheetWidget extends StatefulWidget {
  final Duration initialRestTime;

  const RestCountdownSheetWidget({
    super.key,
    required this.initialRestTime,
  });

  @override
  RestCountdownSheetWidgetState createState() =>
      RestCountdownSheetWidgetState();
}

class RestCountdownSheetWidgetState extends State<RestCountdownSheetWidget> {
  late Duration _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.initialRestTime;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        setState(() {
          _remainingTime -= const Duration(seconds: 1);
        });
      } else {
        _timer?.cancel();
        Navigator.pop(context);
      }
    });
  }

  void _adjustTime(int seconds) {
    setState(() {
      _remainingTime = Duration(
        seconds: (_remainingTime.inSeconds + seconds).clamp(0, 600),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 140,
      decoration: BoxDecoration(
        color: AppColorScheme.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeButton("-15s", -15),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                "${_remainingTime.inMinutes}:${(_remainingTime.inSeconds % 60).toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColorScheme.onPrimary,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              _buildTimeButton("+15s", 15),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _timer?.cancel();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorScheme.primary,
            ),
            child: Text(
              "Close",
              style: TextStyle(
                color: AppColorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeButton(String label, int change) {
    return ElevatedButton(
      onPressed: () => _adjustTime(change),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorScheme.lightBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 15, color: AppColorScheme.onLightBackground)),
    );
  }
}
