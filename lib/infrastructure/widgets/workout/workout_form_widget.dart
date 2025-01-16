import 'package:flutter/material.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/infrastructure/pages/workout/add_workout_exercise_page.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class WorkoutFormWidget extends StatefulWidget {
  final Workout? workout;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const WorkoutFormWidget({
    super.key,
    this.workout,
    required this.onSubmit,
  });

  @override
  State<WorkoutFormWidget> createState() => _WorkoutFormWidgetState();
}

class _WorkoutFormWidgetState extends State<WorkoutFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text =
        widget.workout != null ? widget.workout!.name.value : '';
    _notesController.text =
        widget.workout != null && widget.workout!.notes != null
            ? widget.workout!.notes!.value
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
      widget.onSubmit({
        'name': _nameController.text,
        'notes': _notesController.text,
      });
    }
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
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                      AppColorScheme.onSecondary,
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      AppColorScheme.secondary,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddWorkoutExercisePage(),
                      ),
                    );
                  },
                  child: const Text('Add exercise'),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
