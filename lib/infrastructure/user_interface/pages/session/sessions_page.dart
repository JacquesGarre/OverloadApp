import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/config/modal_action_button_config.dart';
import 'package:overload/infrastructure/user_interface/pages/session/new_session_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/session/current_session_modal_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/list_page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/modal_widget.dart';
import 'package:provider/provider.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({super.key});

  static const String title = 'Sessions';

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SessionProvider>(
        context,
        listen: false,
      ).loadSessions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final SessionProvider sessionProvider = Provider.of<SessionProvider>(
      context,
    );
    return ListPageWidget(
      floatingActionButtonIcon: Icons.play_arrow,
      list: ListView.separated(
        itemCount: sessionProvider.sessions.length,
        itemBuilder: (context, index) {
          return const Text("Session card");
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
    );
  }
}
