import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/infrastructure/user_interface/layout/app_layout.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';

class SessionPage extends StatelessWidget {
  final Session session;

  static const String title = 'Current session';

  const SessionPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AppLayout(
              currentPageIndex: AppLayout.sessionsPageIndex,
            ),
          ),
          (Route<dynamic> route) => false,
        );
      },
      child: const PageWidget(
        title: title,
        child: SingleChildScrollView(
          child: Text("Session running..."),
        ),
      ),
    );
  }
}
