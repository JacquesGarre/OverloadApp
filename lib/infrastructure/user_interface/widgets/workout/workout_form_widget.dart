import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/domain/workout/workout_exercises.dart';
import 'package:overload/infrastructure/user_interface/pages/workout/add_workout_exercise_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/secondary_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/workout_exercise_card_widget.dart';

class WorkoutFormWidget extends StatefulWidget {
  final Workout? workout;

  const WorkoutFormWidget({
    super.key,
    this.workout,
  });

  @override
  State<WorkoutFormWidget> createState() => _WorkoutFormWidgetState();
}

class _WorkoutFormWidgetState extends State<WorkoutFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  WorkoutExercises workoutExercises = WorkoutExercises.empty();

  @override
  void initState() {
    super.initState();
    _nameController.text =
        widget.workout != null ? widget.workout!.name().value() : '';
    _notesController.text =
        widget.workout != null && widget.workout!.notes() != null
            ? widget.workout!.notes()!.value()
            : '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isFormValid = _formKey.currentState!.validate();

    if (isFormValid) {
      // widget.onSubmit({
      //   'name': _nameController.text,
      //   'notes': _notesController.text,
      // });
    }
  }

  void _navigateToAddExercisePage() async {
    WorkoutExerciseIndex index = workoutExercises.last() != null
        ? workoutExercises.last()!.index().next()
        : WorkoutExerciseIndex(value: 1);
    WorkoutExercise? newExercise = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddWorkoutExercisePage(index: index),
      ),
    );
    if (newExercise != null) {
      setState(() {
        workoutExercises = workoutExercises.add(newExercise);
      });
    }
  }

  void _removeWorkoutExercise(WorkoutExercise workoutExercise) {
    setState(() {
      workoutExercises = workoutExercises.remove(workoutExercise);
    });
  }

  void _updateWorkoutExercise(WorkoutExercise workoutExercise) {
    setState(() {
      workoutExercises = workoutExercises.update(workoutExercise);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form( // TODO: Use form widget
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Name"),
            const SizedBox(height: 5.0),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColorScheme.lightBackground,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
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
            const SizedBox(height: 20),
            ...workoutExercises.value().map((workoutExercise) {
              return Column(
                children: [
                  WorkoutExerciseCardWidget(
                    key: ValueKey(workoutExercise.id().value()),
                    workoutExercise: workoutExercise,
                    checkable: false,
                    setsNumberSelector: false,
                    readonly: true,
                    onWorkoutExerciseRemoved: _removeWorkoutExercise,
                    onWorkoutExerciseUpdated: _updateWorkoutExercise,
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                child: SecondaryButtonWidget(
                  text: 'Add exercise',
                  onPressed: _navigateToAddExercisePage,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FloatingCenteredButtonWidget(
              onPressed: _submitForm,
              text: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
