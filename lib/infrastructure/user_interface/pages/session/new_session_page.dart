import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/providers/workout_provider.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/list_page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/start_workout_card_widget.dart';
import 'package:provider/provider.dart';

class NewSessionPage extends StatefulWidget {
  const NewSessionPage({super.key});

  static const String title = 'Select your workout';

  @override
  State<NewSessionPage> createState() => _NewSessionPageState();
}

class _NewSessionPageState extends State<NewSessionPage> {
  late WorkoutProvider workoutProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SessionProvider>(
        context,
        listen: false,
      ).loadCurrentSession();
      Provider.of<WorkoutProvider>(
        context,
        listen: false,
      ).loadWorkouts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final WorkoutProvider workoutProvider = Provider.of<WorkoutProvider>(
      context,
    );
    return PageWidget(
      title: NewSessionPage.title,
      child: ListPageWidget(
        emptyListText:
            "Looks like your workout list is taking a rest day! Add a new workout to get started.",
        itemsCount: workoutProvider.workouts.length,
        list: ListView.separated(
          itemCount: workoutProvider.workouts.length,
          itemBuilder: (context, index) {
            return StartWorkoutCardWidget(
              workout: workoutProvider.workouts[index],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
      ),
    );
  }
}
