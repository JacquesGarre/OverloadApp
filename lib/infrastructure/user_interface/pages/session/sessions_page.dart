import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/pages/session/add_session_page.dart';
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
      fabIcon: Icons.play_arrow,
      list: ListView.separated(
        itemCount: exerciseProvider.sessions.length,
        itemBuilder: (context, index) {
          return const Text("Session card");
          // ExerciseCardWidget(
          //   exercise: exerciseProvider.exercises[index],
          // );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
      onAdd: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddSessionPage(),
          ),
        );
      },
    );
  }
}
