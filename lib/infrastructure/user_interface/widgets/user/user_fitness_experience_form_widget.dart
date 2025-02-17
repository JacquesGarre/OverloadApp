import 'package:flutter/material.dart';
import 'package:overload/domain/user/equipment.dart';
import 'package:overload/domain/user/training_locations.dart';
import 'package:overload/domain/user/training_types.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/badge_selector_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/form_widget.dart';

class UserFitnessExperienceFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const UserFitnessExperienceFormWidget({
    super.key,
    this.user,
    required this.onSubmit,
  });

  @override
  State<UserFitnessExperienceFormWidget> createState() =>
      _UserFitnessExperienceFormWidgetState();
}

class _UserFitnessExperienceFormWidgetState
    extends State<UserFitnessExperienceFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late String _fitnessLevel;
  List<String> _selectedTrainingTypes = [];
  final List<String> _availableTrainingTypes =
      TrainingTypes.all().toStringList();
  String? _trainingTypeError;
  List<String> _selectedTrainingLocations = [];
  final List<String> _availableTrainingLocations =
      TrainingLocations.all().toStringList();
  String? _trainingLocationError;
  List<String> _selectedEquipment = [];
  final List<String> _availableEquipment = Equipment.all().toStringList();
  String? _equipmentError;

  @override
  void initState() {
    super.initState();
    _fitnessLevel = widget.user != null && widget.user!.fitnessLevel() != null
        ? widget.user!.fitnessLevel().toString()
        : 'beginner';
    _selectedTrainingTypes =
        widget.user != null && widget.user!.trainingTypes() != null
            ? widget.user!.trainingTypes()!.toStringList()
            : [];
    _selectedTrainingLocations =
        widget.user != null && widget.user!.trainingLocations() != null
            ? widget.user!.trainingLocations()!.toStringList()
            : [];
    _selectedEquipment = widget.user != null && widget.user!.equipment() != null
        ? widget.user!.equipment()!.toStringList()
        : [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submitForm() {
    final isFormValid = _formKey.currentState!.validate();
    final isTrainingTypesValid = _selectedTrainingTypes.isNotEmpty;
    if (!isTrainingTypesValid) {
      setState(() {
        _trainingTypeError = 'Please select at least one training type';
      });
    }
    final isTrainingLocationsValid = _selectedTrainingLocations.isNotEmpty;
    if (!isTrainingLocationsValid) {
      setState(() {
        _trainingLocationError = 'Please select at least one training location';
      });
    }
    final isEquipmentValid = _selectedEquipment.isNotEmpty;
    if (!isEquipmentValid) {
      setState(() {
        _trainingLocationError = 'Please select at least one equipment';
      });
    }
    if (isFormValid &&
        isTrainingTypesValid &&
        isTrainingLocationsValid &&
        isEquipmentValid) {
      widget.onSubmit({
        'fitness_level': _fitnessLevel,
        'training_types': _selectedTrainingTypes,
        'training_locations': _selectedTrainingLocations,
        'equipment': _selectedEquipment,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormWidget(
      formKey: _formKey,
      fields: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What is your current fitness level?",
            ),
            const SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: 'beginner',
                      groupValue: _fitnessLevel,
                      onChanged: (String? value) {
                        setState(() {
                          _fitnessLevel = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    const Text(
                      'Beginner (never trained or just starting)',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'intermediate',
                      groupValue: _fitnessLevel,
                      onChanged: (String? value) {
                        setState(() {
                          _fitnessLevel = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    const Text(
                      'Intermediate (consistent for 6+ months)',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'advanced',
                      groupValue: _fitnessLevel,
                      onChanged: (String? value) {
                        setState(() {
                          _fitnessLevel = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    const Text(
                      'Advanced (training for 2+ years)',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            BadgeSelectorWidget(
              label: "What type of training do you prefer?",
              items: _availableTrainingTypes,
              selectedItems: _selectedTrainingTypes,
              errorMessage: _trainingTypeError,
            ),
            const SizedBox(
              height: 10.0,
            ),
            BadgeSelectorWidget(
              label: "Where do you plan to work out?",
              items: _availableTrainingLocations,
              selectedItems: _selectedTrainingLocations,
              errorMessage: _trainingLocationError,
            ),
            const SizedBox(
              height: 10.0,
            ),
            BadgeSelectorWidget(
              label: "What equipment do you have access to?",
              items: _availableEquipment,
              selectedItems: _selectedEquipment,
              errorMessage: _equipmentError,
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        )
      ],
      onSubmit: _submitForm,
      submitButtonLabel:
          widget.user != null ? "Update my preferences" : "Save my preferences",
    );
  }
}
