import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exercise.dart';
import 'package:overload/domain/exercise/units.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

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

  @override
  void initState() {
    super.initState();
    _nameController.text =
        widget.exercise != null ? widget.exercise!.name.value : '';
    _selectedUnits =
        widget.exercise != null ? widget.exercise!.units.toStringList() : [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _toggleUnit(String unit) {
    setState(() {
      if (_selectedUnits.contains(unit)) {
        _selectedUnits.remove(unit);
      } else {
        _selectedUnits.add(unit);
      }
      _unitError = null;
    });
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
                labelText: 'Exercise Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Select units you want to track',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: _availableUnits.map((unit) {
                final isSelected = _selectedUnits.contains(unit);
                return FilterChip(
                  label: Text(unit),
                  selected: isSelected,
                  onSelected: (_) => _toggleUnit(unit),
                  selectedColor: Theme.of(context).colorScheme.primary,
                  checkmarkColor: Colors.white,
                );
              }).toList(),
            ),
            if (_unitError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _unitError!,
                  style: TextStyle(
                    color: AppColorScheme.error,
                    fontSize: 12,
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
