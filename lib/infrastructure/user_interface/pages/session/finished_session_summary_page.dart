import 'package:flutter/material.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/widgets/layout/app_bar_widget.dart';
import 'package:provider/provider.dart';

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
  late Session session;

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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(
        title: FinishedSessionSummaryPage.title,
      ),
      body: Column(
        children: [
          Text("Session summary"),
        ],
      ),
    );
  }
}
