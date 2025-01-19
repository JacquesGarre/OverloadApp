import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise.dart';
import 'package:overload/infrastructure/pages/workout/add_goals_page.dart';
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
  final _notesController = TextEditingController();

  Exercise? exercise;
  Sets sets = Sets.empty();
  int numberOfSets = 1;

  @override
  void initState() {
    super.initState();
    sets = widget.workoutExercise != null
        ? widget.workoutExercise!.sets()
        : Sets.empty();
    numberOfSets = widget.workoutExercise != null ? sets.count() : 1;
    _notesController.text = '';
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      widget.onSubmit({});
    }
  }

  void onChange(Exercise? exerciseSelected, int numberOfSetsSelected) {
    Sets newSets = Sets.empty();
    if (exerciseSelected != null) {
      for (int i = 1; i <= numberOfSetsSelected; i++) {
        SetIndex setIndex = SetIndex(value: i);
        Set newSet = sets.findByIndex(setIndex) ??
            Set.fromSetIndexAndExercise(setIndex, exerciseSelected);
        newSets = newSets.add(newSet);
      }
    }
    setState(() {
      exercise = exerciseSelected;
      numberOfSets = numberOfSetsSelected;
      sets = newSets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
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
              ),
              const SizedBox(height: 30.0),
              if (sets.count() > 0 && exercise != null)
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddGoalsPage(
                            exercise: exercise!,
                            sets: sets,
                          ),
                        ),
                      );
                    },
                    child: const Text('Next'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
