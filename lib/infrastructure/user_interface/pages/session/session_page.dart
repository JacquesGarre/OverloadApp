import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/layout/app_layout.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
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
                color: AppColorScheme.lightBackground,
                boxShadow: [
                  BoxShadow(
                    color: AppColorScheme.background.withOpacity(0.2),
                    spreadRadius: 0.1,
                    blurRadius: 0.1,
                    offset: const Offset(0, -3),
                  ),
                ],
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
                        Table(
                          children: [
                            TableRow(
                              children: [
                                Text(
                                  "Time",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColorScheme.onLightBackground,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Sets",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColorScheme.onLightBackground,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Volume",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColorScheme.onLightBackground,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Distance",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColorScheme.onLightBackground,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const TableRow(
                              children: [
                                SizedBox(
                                  height: 4.0,
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                ChronoTimerWidget(
                                  startDate: session.startDate(),
                                ),
                                Text(
                                  "15",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColorScheme.onPrimary,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "1253kg",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColorScheme.onPrimary,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "3.2kms",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColorScheme.onPrimary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle finish session
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColorScheme.onPrimary,
                              backgroundColor: AppColorScheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Finish Session',
                              style: TextStyle(fontSize: 16),
                            ),
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
