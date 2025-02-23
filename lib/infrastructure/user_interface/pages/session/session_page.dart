import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/domain/session/session_exercise/session_exercise_index.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/layout/app_layout.dart';
import 'package:overload/infrastructure/user_interface/pages/session/add_session_exercise_page.dart';
import 'package:overload/infrastructure/user_interface/pages/session/finished_session_summary_page.dart';
import 'package:overload/infrastructure/user_interface/pages/session/sessions_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/session_exercise_card_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/session_notes_form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/session_stats_table_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class SessionPage extends StatefulWidget {
  final Id sessionId;

  static const String title = 'Current session';

  const SessionPage({super.key, required this.sessionId});

  @override
  SessionPageState createState() => SessionPageState();
}

class SessionPageState extends State<SessionPage> {
  Session? session;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Session fetchedSession = await Provider.of<SessionProvider>(
        context,
        listen: false,
      ).getSessionById(widget.sessionId);
      setState(() {
        session = fetchedSession;
      });
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
      Session updatedSession = await sessionProvider.updateSessionExercise(
        session!.id(),
        updatedSessionExercise,
      );
      setState(() {
        session = updatedSession;
      });
    } catch (e) {
      if (!mounted) return;
      ExceptionHandler().handleException(context, e);
    }
  }

  void _navigateToAddSessionExercisePage() async {
    SessionExerciseIndex index = session!.sessionExercises().last() != null
        ? session!.sessionExercises().last()!.index().next()
        : SessionExerciseIndex(value: 1);
    SessionExercise? newExercise = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSessionExercisePage(
          workoutId: session!.workout().id(),
          sessionId: session!.id(),
          index: index,
        ),
      ),
    );
    if (newExercise != null) {
      try {
        if (!mounted) return;
        final sessionProvider = Provider.of<SessionProvider>(
          context,
          listen: false,
        );
        Session updatedSession = await sessionProvider.addSessionExercise(
          session!.id(),
          newExercise,
        );
        setState(() {
          session = updatedSession;
        });
      } catch (e) {
        if (!mounted) return;
        ExceptionHandler().handleException(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<SessionProvider>();
    if (session == null) {
      return const Center(child: CircularProgressIndicator());
    }
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
        title: session!.inProgress() ? SessionPage.title : session!.fullTitle(),
        bottomSheet: DraggableScrollableSheet(
          initialChildSize: 0.12,
          minChildSize: 0.12,
          maxChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            context.watch<SessionProvider>();
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
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        SessionStatsTableWidget(session: session!),
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
              if (!session!.inProgress())
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColorScheme.lightBackground,
                      ),
                    ),
                    onPressed: () {
                      picker.DatePicker.showDateTimePicker(
                        context,
                        showTitleActions: true,
                        maxTime: session!.endDate(),
                        theme: picker.DatePickerTheme(
                          headerColor: AppColorScheme.lightBackground,
                          backgroundColor: AppColorScheme.lightBackground,
                          itemStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          doneStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (startDate) async {
                          SessionProvider sessionProvider =
                              Provider.of<SessionProvider>(
                            context,
                            listen: false,
                          );
                          Session updatedSession =
                              await sessionProvider.updateSession(
                            session!.id(),
                            session!.notes(),
                            startDate,
                            session!.endDate(),
                          );
                          setState(() {
                            session = updatedSession;
                          });
                        },
                        currentTime: session!.startDate(),
                        locale: picker.LocaleType.en,
                      );
                    },
                    child: Text(
                      'Started on ${DateFormat('EEEE, MMM d \'at\' h:mm a').format(session!.startDate())}',
                      style: TextStyle(color: AppColorScheme.primary),
                    )),
              if (!session!.inProgress())
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColorScheme.lightBackground,
                      ),
                    ),
                    onPressed: () {
                      picker.DatePicker.showDateTimePicker(
                        context,
                        showTitleActions: true,
                        minTime: session!.startDate(),
                        maxTime: DateTime.now(),
                        theme: picker.DatePickerTheme(
                          headerColor: AppColorScheme.lightBackground,
                          backgroundColor: AppColorScheme.lightBackground,
                          itemStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          doneStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (endDate) async {
                          SessionProvider sessionProvider =
                              Provider.of<SessionProvider>(
                            context,
                            listen: false,
                          );
                          Session updatedSession =
                              await sessionProvider.updateSession(
                            session!.id(),
                            session!.notes(),
                            session!.startDate(),
                            endDate,
                          );
                          setState(() {
                            session = updatedSession;
                          });
                        },
                        currentTime: session!.endDate(),
                        locale: picker.LocaleType.en,
                      );
                    },
                    child: Text(
                      'Finished on ${DateFormat('EEEE, MMM d \'at\' h:mm a').format(session!.endDate() as DateTime)}',
                      style: TextStyle(color: AppColorScheme.primary),
                    )),
              if (!session!.inProgress())
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: SessionNotesFormWidget(session: session!),
                ),
              ...session!.sessionExercises().value().map(
                (sessionExercise) {
                  return SessionExerciseCardWidget(
                    sessionExercise: sessionExercise,
                    session: session!,
                    onSessionExerciseUpdated: _updateSessionExercise,
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: FloatingCenteredButtonWidget(
                  backgroundColor: AppColorScheme.lightBackground,
                  foregroundColor: AppColorScheme.onPrimary,
                  heroTag: "Add exercise to session",
                  onPressed: () {
                    _navigateToAddSessionExercisePage();
                  },
                  text: 'Add exercise',
                ),
              ),
              if (session!.inProgress())
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: FloatingCenteredButtonWidget(
                    onPressed: () async {
                      try {
                        if (!mounted) return;
                        final sessionProvider = Provider.of<SessionProvider>(
                          context,
                          listen: false,
                        );
                        await sessionProvider.finishCurrentSession();
                        if (!context.mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FinishedSessionSummaryPage(
                              sessionId: session!.id(),
                            ),
                          ),
                        );
                      } catch (e) {
                        if (!context.mounted) return;
                        ExceptionHandler().handleException(context, e);
                      }
                    },
                    text: 'Finish Session',
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: FloatingCenteredButtonWidget(
                  backgroundColor: AppColorScheme.error,
                  onPressed: () async {
                    try {
                      if (!mounted) return;
                      final sessionProvider = Provider.of<SessionProvider>(
                        context,
                        listen: false,
                      );
                      await sessionProvider.deleteCurrentSession();
                      if (!context.mounted) return;
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SessionsPage(),
                        ),
                      );
                    } catch (e) {
                      if (!context.mounted) return;
                      ExceptionHandler().handleException(context, e);
                    }
                  },
                  text: 'Delete session',
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
