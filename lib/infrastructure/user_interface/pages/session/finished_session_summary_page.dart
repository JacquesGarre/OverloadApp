import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/shared/notes.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/layout/app_layout.dart';
import 'package:overload/infrastructure/user_interface/pages/session/sessions_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/session_stats_table_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';

class FinishedSessionSummaryPage extends StatefulWidget {
  final Id sessionId;

  static const String title = 'Session summary';

  const FinishedSessionSummaryPage({super.key, required this.sessionId});

  @override
  FinishedSessionSummaryPageState createState() =>
      FinishedSessionSummaryPageState();
}

class FinishedSessionSummaryPageState
    extends State<FinishedSessionSummaryPage> {
  final _notesController = TextEditingController();
  late ConfettiController _confettiController;
  Session? session;
  Notes? notes;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Session fetchedSession = await Provider.of<SessionProvider>(
        context,
        listen: false,
      ).getSessionById(widget.sessionId);
      setState(() {
        session = fetchedSession;
        _notesController.text =
            session!.notes() != null ? session!.notes()!.value() : "";
        notes = session!.notes();
      });
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _updateNotes(String value) async {
    try {
      Notes? notes = Notes.fromString(value);
      SessionProvider sessionProvider =
          Provider.of<SessionProvider>(context, listen: false);
      await sessionProvider.updateSession(session!.id(), notes);
      if (!mounted) return;
    } catch (e) {
      ExceptionHandler().handleException(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (session == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return PageWidget(
      title: FinishedSessionSummaryPage.title,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: AppColorScheme.onLightBackground,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Center(
                child: Text(
                  session!.workout().name().value(),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Center(
                child: Text(
                  DateFormat('EEEE, MMM d \'at\' h:mm a')
                      .format(session!.endDate() as DateTime),
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: AppColorScheme.onLightBackground,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Notes"),
              const SizedBox(height: 5.0),
              TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColorScheme.lightBackground,
                    border: const OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  onChanged: (String value) {
                    _updateNotes(value);
                  }),
              const SizedBox(
                height: 12.0,
              ),
              Divider(
                color: AppColorScheme.onLightBackground,
              ),
              const SizedBox(
                height: 10.0,
              ),
              SessionStatsTableWidget(session: session!),
              // TODO: Add calendar of the current month and how many times have trained in current month
              // TODO: Add session number
              // TODO: Add sessions over the last 7 days
              // TODO: add progress indicators and highlights
              const SizedBox(
                height: 20.0,
              ),
              FloatingCenteredButtonWidget(
                onPressed: () {
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
                text: "Go to my sessions",
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
