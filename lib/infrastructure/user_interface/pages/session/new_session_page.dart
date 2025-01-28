import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/workout_provider.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/list_page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/start_workout_card_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/workout_card_widget.dart';
import 'package:provider/provider.dart';

class NewSessionPage extends StatefulWidget {
  const NewSessionPage({super.key});

  static const String title = 'Choose a workout';

  @override
  State<NewSessionPage> createState() => _NewSessionPageState();
}

class _NewSessionPageState extends State<NewSessionPage> {
  late WorkoutProvider workoutProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<WorkoutProvider>(
        context,
        listen: false,
      ).loadWorkouts();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    workoutProvider = Provider.of<WorkoutProvider>(
      context,
      listen: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      title: NewSessionPage.title,
      child: ListPageWidget(
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
