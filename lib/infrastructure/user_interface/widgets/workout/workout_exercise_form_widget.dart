import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/shared/notes.dart';
import 'package:overload/domain/workout/workout_exercise/sets_count.dart';
import 'package:overload/domain/workout/workout_exercise/timer.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/infrastructure/user_interface/pages/workout/goals_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/exercise/exercise_dropdown_widget.dart';
import 'package:number_selector/number_selector.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/rest_time_picker_widget.dart';

class WorkoutExerciseFormWidget extends StatefulWidget {
  final Id workoutId;
  final WorkoutExerciseIndex index;
  final WorkoutExercise? workoutExercise;

  const WorkoutExerciseFormWidget({
    super.key,
    required this.workoutId,
    required this.index,
    this.workoutExercise,
  });

  @override
  State<WorkoutExerciseFormWidget> createState() =>
      _WorkoutExerciseFormWidgetState();
}

class _WorkoutExerciseFormWidgetState extends State<WorkoutExerciseFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  Exercise? exercise;
  Notes? notes;
  SetsCount setsCount = SetsCount(value: 1);
  int numberOfSets = 1;
  Duration restTime = const Duration(minutes: 1, seconds: 00);
  bool _trackRestTime = false;

  @override
  void initState() {
    super.initState();
    setsCount = widget.workoutExercise != null
        ? widget.workoutExercise!.setsCount()
        : SetsCount(value: 1);
    numberOfSets = setsCount.value();
    _notesController.text = widget.workoutExercise != null &&
            widget.workoutExercise!.notes() != null
        ? widget.workoutExercise!.notes()!.value()
        : "";
    notes = widget.workoutExercise != null &&
            widget.workoutExercise!.notes() != null
        ? widget.workoutExercise!.notes()
        : null;
    exercise = widget.workoutExercise?.exercise();
    restTime = widget.workoutExercise != null &&
            widget.workoutExercise!.timer() != null
        ? Duration(seconds: widget.workoutExercise!.timer()!.value())
        : const Duration(minutes: 1, seconds: 00);
  }

  void pickRestTime() async {
    Duration? pickedTime = await showRestTimePicker(context, restTime);
    if (pickedTime != null) {
      setState(() {
        restTime = pickedTime;
      });
    }
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

  void _navigateToAddGoalsPage(
      Exercise exercise, SetsCount setsCount, Notes? notes) async {
    WorkoutExercise? workoutExercise = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalsPage(
          workoutId: widget.workoutId,
          index: widget.index,
          exercise: exercise,
          setsCount: setsCount,
          notes: notes,
          workoutExercise: widget.workoutExercise,
          timer: _trackRestTime ? Timer(value: restTime.inSeconds) : null,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Track rest time"),
                  Switch(
                    value: _trackRestTime,
                    onChanged: (bool value) {
                      setState(() {
                        _trackRestTime = value;
                      });
                    },
                  ),
                ],
              ),
              if (_trackRestTime)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Rest time"),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            AppColorScheme.lightBackground),
                        foregroundColor:
                            WidgetStatePropertyAll(AppColorScheme.onPrimary),
                      ),
                      onPressed: pickRestTime,
                      child: Text(
                          "${restTime.inMinutes > 0 ? "${restTime.inMinutes} min${restTime.inMinutes > 1 ? "s" : ""}" : ""} ${restTime.inSeconds % 60 > 0 ? "${restTime.inSeconds % 60} secs" : ""}"),
                    ),
                  ],
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
                    _navigateToAddGoalsPage(exercise!, setsCount, notes);
                  },
                  text: 'Next',
                )
            ],
          ),
        ),
      ),
    );
  }
}
