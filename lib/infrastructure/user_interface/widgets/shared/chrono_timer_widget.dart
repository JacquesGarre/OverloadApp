import 'dart:async';
import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class ChronoTimerWidget extends StatefulWidget {
  final DateTime startDate;

  const ChronoTimerWidget({super.key, required this.startDate});

  @override
  ChronoTimerWidgetState createState() => ChronoTimerWidgetState();
}

class ChronoTimerWidgetState extends State<ChronoTimerWidget> {
  late Timer _timer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startChrono();
  }

  void _startChrono() {
    _elapsed = DateTime.now().difference(widget.startDate);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed = DateTime.now().difference(widget.startDate);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final hoursString = duration.inHours == 0
        ? ""
        : "${hours}h${duration.inHours > 1 ? "rs " : " "}";
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final minutesString = duration.inMinutes == 0
        ? ""
        : "${minutes}min${duration.inMinutes > 1 ? "s " : " "}";
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final secondsString = duration.inSeconds == 0 ? "" : "${seconds}s";
    return "$hoursString$minutesString$secondsString";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(_elapsed),
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColorScheme.primary,
        fontSize: 12,
      ),
    );
  }
}
