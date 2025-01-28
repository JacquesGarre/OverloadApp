import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';

class SessionPage extends StatelessWidget {
  final Session session;

  static const String title = 'Current session';

  const SessionPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      title: title,
      child: SingleChildScrollView(
        child: Text("Session running..."),
      ),
    );
  }
}
