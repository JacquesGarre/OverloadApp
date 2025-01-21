import 'package:flutter/material.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';

class PageWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? floatingActionButton;

  const PageWidget(
      {super.key,
      required this.title,
      required this.child,
      this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: title,
      ),
      body: SingleChildScrollView(
        child: child,
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: floatingActionButton,
    );
  }
}
