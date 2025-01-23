import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/set/set_index.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/infrastructure/user_interface/pages/workout/goals_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/exercise/exercise_dropdown_widget.dart';
import 'package:number_selector/number_selector.dart';
import 'package:overload/domain/workout/set/set.dart';

class WorkoutExerciseFormWidget extends StatefulWidget {
  final WorkoutExerciseIndex index;
  final WorkoutExercise? workoutExercise;

  const WorkoutExerciseFormWidget({
    super.key,
    required this.index,
    this.workoutExercise,
  });

  @override
  State<WorkoutExerciseFormWidget> createState() =>
      _WorkoutExerciseFormWidgetState();
}

// TODO: Add minuteur de repos
class _WorkoutExerciseFormWidgetState extends State<WorkoutExerciseFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  Exercise? exercise;
  Notes? notes;
  Sets sets = Sets.empty();
  int numberOfSets = 1;

  @override
  void initState() {
    super.initState();
    sets = widget.workoutExercise != null
        ? widget.workoutExercise!.sets()
        : Sets.empty();
    numberOfSets = widget.workoutExercise != null ? sets.count() : 1;
    _notesController.text = widget.workoutExercise != null &&
            widget.workoutExercise!.notes() != null
        ? widget.workoutExercise!.notes()!.value()
        : "";
    notes = widget.workoutExercise != null &&
            widget.workoutExercise!.notes() != null
        ? widget.workoutExercise!.notes()
        : null;
    exercise = widget.workoutExercise?.exercise();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _onChange(Exercise? exerciseSelected, int numberOfSetsSelected) {
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

  void _updateNotes(String value) {
    setState(() {
      notes = Notes(value: value);
    });
  }

  void _navigateToAddGoalsPage(
      Exercise exercise, Sets sets, Notes? notes) async {
    WorkoutExercise? workoutExercise = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalsPage(
          index: widget.index,
          exercise: exercise,
          sets: sets,
          notes: notes,
          workoutExercise: widget.workoutExercise,
        ),
      ),
    );
    if (workoutExercise != null) {
      if (!mounted) return;
      Navigator.pop(context, workoutExercise);
    }
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
                initialExercise: widget.workoutExercise?.exercise(),
                onChanged: (Exercise? exerciseSelected) {
                  _onChange(exerciseSelected, numberOfSets);
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
                  _onChange(exercise, number);
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
                  onChanged: (String value) {
                    _updateNotes(value);
                  }),
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
                      _navigateToAddGoalsPage(exercise!, sets, notes);
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
