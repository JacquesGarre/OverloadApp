import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/widgets/exercise/exercise_dropdown_widget.dart';
import 'package:number_selector/number_selector.dart';
import 'package:overload/domain/workout/set/set.dart';

class WorkoutExerciseFormWidget extends StatefulWidget {
  final WorkoutExercise? workoutExercise;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const WorkoutExerciseFormWidget({
    super.key,
    this.workoutExercise,
    required this.onSubmit,
  });

  @override
  State<WorkoutExerciseFormWidget> createState() =>
      _WorkoutExerciseFormWidgetState();
}

class _WorkoutExerciseFormWidgetState extends State<WorkoutExerciseFormWidget> {
  final _formKey = GlobalKey<FormState>();

  Exercise? exercise;
  Sets? sets;
  int numberOfSets = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submitForm() {
    final isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      widget.onSubmit({});
    }
  }

  void onChange(Exercise? exerciseSelected, int numberOfSetsSelected) {
    // TODO : Have a method in Sets class domain directly to generate the sets.
    Sets newSets = widget.workoutExercise != null ? widget.workoutExercise!.sets : Sets.empty();
    if (exerciseSelected != null) {
      for (int i = 1; i <= numberOfSetsSelected; i++) {
        SetIndex setIndex = SetIndex(value: i);
        newSets = newSets.add(
          Set.fromSetIndexAndExercise(setIndex, exerciseSelected),
        );
      }
    }
    setState(() {
      exercise = exerciseSelected;
      numberOfSets = numberOfSetsSelected;
      sets = newSets;
    });
    Logger().i(sets?.value.length);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Exercise"),
            const SizedBox(height: 5.0),
            ExerciseDropdownWidget(
              onChange: (Exercise? exerciseSelected) {
                onChange(exerciseSelected, numberOfSets);
              },
            ),
            const SizedBox(height: 16),
            const Text("Number of sets"),
            const SizedBox(height: 5.0),
            NumberSelector.plain(
              width: double.infinity,
              height: 58,
              iconColor: AppColorScheme.primary,
              borderRadius: 5.0,
              backgroundColor: AppColorScheme.lightBackground,
              borderColor: Colors.white,
              showMinMax: false,
              showSuffix: false,
              hasDividers: false,
              hasBorder: true,
              current: numberOfSets,
              min: 1,
              max: 30,
              onUpdate: (number) {
                onChange(exercise, number);
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(
                    AppColorScheme.onPrimary,
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    AppColorScheme.primary,
                  ),
                ),
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
