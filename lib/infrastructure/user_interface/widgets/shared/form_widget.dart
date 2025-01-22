import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/floating_centered_button_widget.dart';

class FormWidget extends StatelessWidget {
  final Key formKey;
  final List<Widget> fields;
  final VoidCallback onSubmit;
  final String submitButtonLabel;

  const FormWidget({
    super.key,
    required this.formKey,
    required this.fields,
    required this.onSubmit,
    required this.submitButtonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...fields.map((field) {
              return Column(
                children: [
                  field,
                  const SizedBox(height: 16),
                ],
              );
            }),
            FloatingCenteredButtonWidget(
              onPressed: onSubmit,
              text: submitButtonLabel,
            ),
          ],
        ),
      ),
    );
  }
}
