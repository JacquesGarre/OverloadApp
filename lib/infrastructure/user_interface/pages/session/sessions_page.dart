import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/pages/session/new_session_page.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/list_page_widget.dart';
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
      ).loadExercises();
    });
  }

  @override
  Widget build(BuildContext context) {
    final SessionProvider exerciseProvider = Provider.of<SessionProvider>(
      context,
    );
    return ListPageWidget(
      floatingActionButtonIcon: Icons.play_arrow,
      list: ListView.separated(
        itemCount: exerciseProvider.sessions.length,
        itemBuilder: (context, index) {
          return const Text("Session card");
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
      onFloatingActionButtonPressed: () {
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
