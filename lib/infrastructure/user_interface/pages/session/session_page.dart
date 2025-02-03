import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/layout/app_layout.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/session_exercise_card_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/chrono_timer_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/primary_button_widget.dart';
import 'package:provider/provider.dart';

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

  Future<void> _updateSessionExercise(
    SessionExercise updatedSessionExercise,
  ) async {
    try {
      final sessionProvider = Provider.of<SessionProvider>(
        context,
        listen: false,
      );
      await sessionProvider.updateSessionExercise(
        session.id(),
        updatedSessionExercise,
      );
    } catch (e) {
      if (!mounted) return;
      ExceptionHandler().handleException(context, e);
    }
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
        bottomSheet: DraggableScrollableSheet(
          initialChildSize: 0.12,
          minChildSize: 0.12,
          maxChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Row(
                          children: [
                            ChronoTimerWidget(startDate: session.startDate(),),
                            Text("Sets: 15"),
                            Text("Volume: 1253kg"),
                            
                            ],
                        ),

                        SizedBox(height: 10),

                        // Example Summary Details
                        Text("TEST"),

                        SizedBox(height: 20),

                        // Finish Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle finish session
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text('Finish Session',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
