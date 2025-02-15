import 'package:flutter/material.dart';
import 'package:overload/domain/user/fitness_goals.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/badge_selector_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/text_field_widget.dart';

class UserFitnessGoalsFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const UserFitnessGoalsFormWidget({
    super.key,
    this.user,
    required this.onSubmit,
  });

  @override
  State<UserFitnessGoalsFormWidget> createState() =>
      _UserFitnessGoalsFormWidgetState();
}

class _UserFitnessGoalsFormWidgetState
    extends State<UserFitnessGoalsFormWidget> {
  final _formKey = GlobalKey<FormState>();
  List<String> _selectedGoals = [];
  final List<String> _availableGoals = FitnessGoals.all().toStringList();
  String? _goalError;

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

  @override
  Widget build(BuildContext context) {
    return FormWidget(
      formKey: _formKey,
      fields: [
        Center(
          child: BadgeSelectorWidget(
            label: "What are your fitness goals?",
            items: _availableGoals,
            selectedItems: _selectedGoals,
            errorMessage: _goalError,
          ),
        ),
      ],
      onSubmit: _submitForm,
      submitButtonLabel:
          widget.user != null ? "Update my profile" : "Create my profile",
    );
  }
}
