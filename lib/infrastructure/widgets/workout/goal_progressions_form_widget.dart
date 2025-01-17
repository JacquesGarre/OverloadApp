import 'package:flutter/material.dart';
import 'package:overload/infrastructure/pages/workout/add_workout_exercise_page.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class GoalProgressionsFormWidget extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const GoalProgressionsFormWidget({
    super.key,
    required this.onSubmit,
  });

  @override
  State<GoalProgressionsFormWidget> createState() =>
      _GoalProgressionsFormWidgetState();
}

class _GoalProgressionsFormWidgetState
    extends State<GoalProgressionsFormWidget> {
  final _formKey = GlobalKey<FormState>();

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
      widget.onSubmit({
        // 'name': _nameController.text,
        // 'notes': _notesController.text,
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
            const Align(
              child: Text("Define your progression rules for future sessions"),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Align(
              child: Text(
                "After reaching your goal, how would you like each set to evolve?",
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),

/*

Step 2: Set Progression Rules

Set	        Progression Rule

Set1	      Increase Kgs by [ +5 ]
            Increase Reps by [ +1 ]

Set2	      Increase Kgs by [ +5 ]
            Increase Reps by [ +1 ]




Step 3: Configure Milestones

[
  Milestone: When Set1 reaches 12 Reps
  - Increase Kgs to [ 15 ]
  - Reset Reps to [ 10 ]
  - Add Set: [ Yes ]
  New Set Configuration
  Set3: 15kg, 8reps
]


*/

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
                child: const Text('Add exercise to your workout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
