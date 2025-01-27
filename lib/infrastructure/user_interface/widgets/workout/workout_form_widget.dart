import 'package:flutter/material.dart';
import 'package:overload/domain/workout/id.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise.dart';
import 'package:overload/domain/workout/workout_exercise/workout_exercise_index.dart';
import 'package:overload/domain/workout/workout_exercises.dart';
import 'package:overload/infrastructure/user_interface/pages/workout/add_workout_exercise_page.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/secondary_button_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/text_field_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/workout/workout_exercise_card_widget.dart';

class WorkoutFormWidget extends StatefulWidget {
  final Workout? workout;
  final Function(
    Id? id,
    String name,
    String? notes,
    WorkoutExercises workoutExercises,
  ) onSubmit;

  const WorkoutFormWidget({
    super.key,
    required this.onSubmit,
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
  String? _workoutExercisesError;
  late Id workoutId;

  @override
  void initState() {
    super.initState();
    workoutId = widget.workout != null ? widget.workout!.id() : Id.create();
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

    final isWorkoutExercisesValid = workoutExercises.value().isNotEmpty;
    if (!isWorkoutExercisesValid) {
      setState(() {
        _workoutExercisesError =
            'Please add at least one exercise to your workout';
      });
    }
    if (isFormValid && isWorkoutExercisesValid) {
      widget.onSubmit(
        workoutId,
        _nameController.text,
        _notesController.text,
        workoutExercises,
      );
    }
  }

  void _navigateToAddExercisePage() async {
    WorkoutExerciseIndex index = workoutExercises.last() != null
        ? workoutExercises.last()!.index().next()
        : WorkoutExerciseIndex(value: 1);
    WorkoutExercise? newExercise = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddWorkoutExercisePage(
          workoutId: workoutId,
          index: index,
        ),
      ),
    );
    if (newExercise != null) {
      setState(() {
        workoutExercises = workoutExercises.add(newExercise);
        _workoutExercisesError = null;
      });
    }
  }

  void _removeWorkoutExercise(WorkoutExercise workoutExercise) {
    setState(() {
      workoutExercises = workoutExercises.remove(workoutExercise);
      _workoutExercisesError = null;
    });
  }

  void _updateWorkoutExercise(WorkoutExercise workoutExercise) {
    setState(() {
      workoutExercises = workoutExercises.update(workoutExercise);
      _workoutExercisesError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormWidget(
      formKey: _formKey,
      submitButtonLabel: 'Save workout',
      onSubmit: _submitForm,
      fields: [
        TextFieldWidget(
          label: "Name",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          controller: _nameController,
        ),
        TextFieldWidget(
          label: "Notes",
          controller: _notesController,
          maxLines: 3,
        ),
        ...workoutExercises.value().map((workoutExercise) {
          return Column(
            children: [
              WorkoutExerciseCardWidget(
                workoutId: widget.workout != null ? widget.workout!.id() : workoutId,
                key: ValueKey(workoutExercise.id().value()),
                workoutExercise: workoutExercise,
                checkable: false,
                setsNumberSelector: false,
                readonly: true,
                onWorkoutExerciseRemoved: _removeWorkoutExercise,
                onWorkoutExerciseUpdated: _updateWorkoutExercise,
              ),
              const SizedBox(height: 8),
            ],
          );
        }),
        const SizedBox(height: 8),
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
        if (_workoutExercisesError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _workoutExercisesError!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
