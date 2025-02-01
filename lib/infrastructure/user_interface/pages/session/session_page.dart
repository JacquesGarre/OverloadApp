import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/infrastructure/user_interface/layout/app_layout.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/session_exercise_card_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/primary_button_widget.dart';

class SessionPage extends StatefulWidget {
  final Session session;

  static const String title = 'Current session';

  const SessionPage({super.key, required this.session});

  @override
  SessionPageState createState() => SessionPageState();
}

class SessionPageState extends State<SessionPage> {
  late Session session;

  @override
  void initState() {
    super.initState();
    setState(() {
      session = widget.session;
    });
  }

  void _updateSessionExercise(SessionExercise updatedSessionExercise) {
    session = session.updateSessionExercise(updatedSessionExercise); // TODO: Should call provider + command + persist eventbus publish
    Logger().e("session UPDATED");
  }

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
      child: PageWidget(
        title: SessionPage.title,
        footerButtons: [
          PrimaryButtonWidget(text: "Finish session", onPressed: (){}),
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...session.sessionExercises().value().map(
                (sessionExercise) {
                  return SessionExerciseCardWidget(
                    sessionExercise: sessionExercise,
                    onSessionExerciseUpdated: _updateSessionExercise,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
