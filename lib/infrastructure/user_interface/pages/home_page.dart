import 'package:flutter/material.dart';
import 'package:overload/_tmp/exercise/exercise_stub.dart';
import 'package:overload/_tmp/workout/sets_stub.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/infrastructure/user_interface/widgets/sets/sets_table_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String title = 'Home';

  @override
  Widget build(BuildContext context) {
    Exercise exercise = ExerciseStub.random();
    Sets sets = SetsStub.fromExercise(exercise);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SetsTableWidget(
            exercise: exercise,
            sets: sets,
            checkable: false,
            setsNumberSelector: true,
            onSetsUpdated: (Sets sets) {

            },
            readonly: false,
          ),
        ],
      ),
    );
  }
}
