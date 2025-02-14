import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/badge_selector_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/text_field_widget.dart';

class ExerciseFormWidget extends StatefulWidget {
  final Exercise? exercise;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const ExerciseFormWidget({
    super.key,
    this.exercise,
    required this.onSubmit,
  });

  @override
  State<ExerciseFormWidget> createState() => _ExerciseFormWidgetState();
}

class _ExerciseFormWidgetState extends State<ExerciseFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  List<String> _selectedUnits = [];
  final List<String> _availableUnits = Units.all().toStringList();
  String? _unitError;
  bool _isBodyWeightExercise = false;

  @override
  void initState() {
    super.initState();
    _nameController.text =
        widget.exercise != null ? widget.exercise!.name().value() : '';
    _selectedUnits =
        widget.exercise != null ? widget.exercise!.units().toStringList() : [];
    _isBodyWeightExercise = widget.exercise != null
        ? widget.exercise!.isBodyWeightExercise().value()
        : false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isFormValid = _formKey.currentState!.validate();
    final isUnitsValid = _selectedUnits.isNotEmpty;
    if (!isUnitsValid) {
      setState(() {
        _unitError = 'Please select at least one unit';
      });
    }
    if (isFormValid && isUnitsValid) {
      widget.onSubmit({
        'name': _nameController.text,
        'units': _selectedUnits,
        'is_body_weight_exercise': _isBodyWeightExercise,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormWidget(
      formKey: _formKey,
      fields: [
        TextFieldWidget(
          label: "Name",
          controller: _nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
        ),
        BadgeSelectorWidget(
          label: "Units",
          items: _availableUnits,
          selectedItems: _selectedUnits,
          errorMessage: _unitError,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Bodyweight Exercise"),
            Switch(
              value: _isBodyWeightExercise,
              onChanged: (bool value) {
                setState(() {
                  _isBodyWeightExercise = value;
                });
              },
            ),
          ],
        ),
      ],
      onSubmit: _submitForm,
      submitButtonLabel:
          widget.exercise != null ? "Update exercise" : "Add exercise",
    );
  }
}
