import 'package:flutter/material.dart';

class FutureWidget extends StatelessWidget {

  final AsyncSnapshot<void> snapshot;
  final Widget widget;

  const FutureWidget({super.key, required this.snapshot, required this.widget});

  @override
  Widget build(BuildContext context) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      return widget;
  }

}