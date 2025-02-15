import 'package:flutter/material.dart';
import 'package:number_selector/number_selector.dart';
import 'package:overload/domain/user/fitness_goals.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
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
  late int _workoutWeeklyDays;
  late int _workoutDurationPreference;

  @override
  void initState() {
    super.initState();
    _selectedGoals = widget.user != null && widget.user!.fitnessGoals() != null
        ? widget.user!.fitnessGoals()!.toStringList()
        : [];
    _workoutWeeklyDays =
        widget.user != null && widget.user!.workoutWeeklyDays() != null
            ? widget.user!.workoutWeeklyDays()!.value()
            : 3;
    _workoutDurationPreference =
        widget.user != null && widget.user!.workoutDurationPreference() != null
            ? widget.user!.workoutDurationPreference()!.value()
            : 45;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submitForm() {
    final isFormValid = _formKey.currentState!.validate();
    final isGoalsValid = _selectedGoals.isNotEmpty;
    if (!isGoalsValid) {
      setState(() {
        _goalError = 'Please select at least one fitness goal';
      });
    }
    if (isFormValid) {
      widget.onSubmit({
        'fitness_goals': _selectedGoals,
        'workout_weekly_days': _workoutWeeklyDays,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormWidget(
      formKey: _formKey,
      fields: [
        BadgeSelectorWidget(
          label: "What are your fitness goals?",
          items: _availableGoals,
          selectedItems: _selectedGoals,
          errorMessage: _goalError,
        ),
        const SizedBox(
          height: 6.0,
        ),
        const Text("How many days per week would you like to workout?"),
        Center(
          child: NumberSelector.plain(
            width: double.infinity,
            height: 40,
            iconColor: AppColorScheme.primary,
            borderRadius: 5.0,
            backgroundColor: AppColorScheme.lightBackground,
            borderColor: Colors.transparent,
            showMinMax: false,
            showSuffix: false,
            hasDividers: false,
            hasBorder: true,
            current: _workoutWeeklyDays,
            min: 1,
            max: 7,
            onUpdate: (int value) {
              setState(() {
                _workoutWeeklyDays = value;
              });
            },
          ),
        ),
        const Text("What is your ideal workout duration in minutes?"),
        Center(
          child: NumberSelector.plain(
            step: 15,
            width: double.infinity,
            height: 40,
            iconColor: AppColorScheme.primary,
            borderRadius: 5.0,
            backgroundColor: AppColorScheme.lightBackground,
            borderColor: Colors.transparent,
            showMinMax: false,
            showSuffix: false,
            hasDividers: false,
            hasBorder: true,
            current: _workoutDurationPreference,
            min: 15,
            max: 240,
            onUpdate: (int value) {
              setState(() {
                _workoutDurationPreference = value;
              });
            },
          ),
        )
      ],
      onSubmit: _submitForm,
      submitButtonLabel: "Save my preferences",
    );
  }
}
