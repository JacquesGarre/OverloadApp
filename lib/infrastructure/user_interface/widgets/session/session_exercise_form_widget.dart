import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/session/id.dart';
import 'package:overload/domain/workout/id.dart' as workout;
import 'package:overload/domain/workout/workout_exercise/id.dart'
    as workout_exercise;

import 'package:overload/domain/session/session_exercise/session_exercise.dart';
import 'package:overload/domain/session/session_exercise/session_exercise_index.dart';
import 'package:overload/domain/workout/notes.dart';
import 'package:overload/domain/workout/sets.dart';
import 'package:overload/domain/workout/workout_exercise/sets_count.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/exercise/exercise_dropdown_widget.dart';
import 'package:number_selector/number_selector.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';

class SessionExerciseFormWidget extends StatefulWidget {
  final Id sessionId;
  final workout.Id workoutId;
  final SessionExerciseIndex index;
  final SessionExercise? sessionExercise;

  const SessionExerciseFormWidget({
    super.key,
    required this.sessionId,
    required this.workoutId,
    required this.index,
    this.sessionExercise,
  });

  @override
  State<SessionExerciseFormWidget> createState() =>
      _SessionExerciseFormWidgetState();
}

// TODO: Add minuteur de repos
class _SessionExerciseFormWidgetState extends State<SessionExerciseFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  Exercise? exercise;
  Notes? notes;
  SetsCount setsCount = SetsCount(value: 1);
  int numberOfSets = 1;

  @override
  void initState() {
    super.initState();
    setsCount = widget.sessionExercise != null
        ? widget.sessionExercise!.workoutExercise().setsCount()
        : SetsCount(value: 1);
    numberOfSets = setsCount.value();
    _notesController.text = widget.sessionExercise != null &&
            widget.sessionExercise!.notes() != null
        ? widget.sessionExercise!.notes()!.value()
        : "";
    notes = widget.sessionExercise != null &&
            widget.sessionExercise!.notes() != null
        ? widget.sessionExercise!.notes()
        : null;
    exercise = widget.sessionExercise?.workoutExercise().exercise();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _onChange(Exercise? exerciseSelected, int numberOfSetsSelected) {
    setState(() {
      exercise = exerciseSelected;
      numberOfSets = numberOfSetsSelected;
      setsCount = SetsCount(value: numberOfSets);
    });
  }

  void _updateNotes(String value) {
    setState(() {
      notes = Notes.fromString(value);
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
                initialExercise:
                    widget.sessionExercise?.workoutExercise().exercise(),
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
              if (setsCount.value() > 0 && exercise != null)
                FloatingCenteredButtonWidget(
                  onPressed: () {
                    Sets sets = Sets.fromSetsCountAndExercise(
                      setsCount,
                      exercise!,
                    );
                    WorkoutExercise workoutExercise = WorkoutExercise(
                      id: workout_exercise.Id.create(),
                      workoutId: widget.workoutId,
                      index: WorkoutExerciseIndex(value: widget.index.value()),
                      exercise: exercise!,
                      setsCount: setsCount,
                    );
                    SessionExercise sessionExercise = SessionExercise(
                      index: widget.index,
                      workoutExercise: workoutExercise,
                      sets: sets,
                      notes: notes,
                    );
                    Navigator.pop(context, sessionExercise);
                  },
                  text: 'Add exercise',
                )
            ],
          ),
        ),
      ),
    );
  }
}
