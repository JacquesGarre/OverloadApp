import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/pages/session/new_session_page.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/current_session_modal_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/current_session_card_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/finished_session_card_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/list_page_widget.dart';
import 'package:provider/provider.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({super.key});

  static const String title = 'Sessions';

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  late ScrollController scrollController;
  bool loading = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final SessionProvider sessionProvider = Provider.of<SessionProvider>(
        context,
        listen: false,
      );
      await sessionProvider.loadSessions();
    });
  }

  void _onScroll() async {
    if (scrollController.position.extentAfter == 0 && !loading) {
      setState(() {
        loading = true;
      });
      final SessionProvider sessionProvider = Provider.of<SessionProvider>(
        context,
        listen: false,
      );
      await sessionProvider.loadMoreSessions(currentPage);
      setState(() {
        currentPage++;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionProvider sessionProvider = Provider.of<SessionProvider>(
      context,
    );
    return Scrollbar(
      child: ListPageWidget(
        itemsCount: sessionProvider.sessions.length,
        emptyListText:
            "Looks like your session list is taking a rest day! Tap the start button to get started!",
        floatingActionButtonIcon: Icons.play_arrow,
        list: ListView.separated(
          controller: scrollController,
          itemCount: sessionProvider.sessions.length,
          itemBuilder: (context, index) {
            Session session = sessionProvider.sessions[index];
            return session.inProgress()
                ? CurrentSessionCardWidget(session: session)
                : FinishedSessionCardWidget(session: session);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
        onFloatingActionButtonPressed: () async {
          await sessionProvider.loadCurrentSession();
          if (!context.mounted) return;
          if (sessionProvider.currentSession != null) {
            showCurrentSessionModal(
              context: context,
              sessionProvider: sessionProvider,
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewSessionPage(),
            ),
          );
        },
      ),
    );
  }
}
