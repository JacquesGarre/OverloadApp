import 'package:flutter/material.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/text_field_widget.dart';

class UserProfileFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const UserProfileFormWidget({
    super.key,
    this.user,
    required this.onSubmit,
  });

  @override
  State<UserProfileFormWidget> createState() => _UserProfileFormWidgetState();
}

class _UserProfileFormWidgetState extends State<UserProfileFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  late int _age;
  late num _weight;
  late String _gender;

  @override
  void initState() {
    super.initState();
    _usernameController.text =
        widget.user != null ? widget.user!.username().value() : '';
    _age = widget.user != null ? widget.user!.age().value() : 18;
    _weight = widget.user != null ? widget.user!.weight().value() : 50;
    _gender = widget.user != null ? widget.user!.gender().value() : 'Male';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      widget.onSubmit({
        'username': _usernameController.text,
        'age': _age,
        'weight': _weight,
        'gender': _gender,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormWidget(
      formKey: _formKey,
      fields: [
        TextFieldWidget(
          label: "Your username",
          controller: _usernameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a username';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 1.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your age: $_age',
            ),
            Slider(
              value: _age.toDouble(),
              min: 10,
              max: 100,
              divisions: 90,
              label: _age.toString(),
              onChanged: (double value) {
                setState(() {
                  _age = value.round();
                });
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.grey.shade300,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your weight: $_weight kgs',
            ),
            Slider(
              value: _weight.toDouble(),
              min: 30,
              max: 200,
              divisions: 170,
              label: '$_weight kgs',
              onChanged: (double value) {
                setState(() {
                  _weight = value.round();
                });
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.grey.shade300,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Gender',
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    const Text('Male'),
                    const SizedBox(width: 10),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    const Text('Female'),
                    const SizedBox(width: 10),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Other',
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    const Text('Other'),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
      onSubmit: _submitForm,
      submitButtonLabel:
          widget.user != null ? "Update my profile" : "Create my profile",
    );
  }
}
