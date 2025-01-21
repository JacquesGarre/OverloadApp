import 'package:flutter/material.dart';
import 'package:overload/infrastructure/widgets/layout/app_bar_widget.dart';

class FormPageWidget extends StatelessWidget {
  final String title;
  final Widget form;

  const FormPageWidget({super.key, required this.title, required this.form});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: title,
      ),
      body: SingleChildScrollView(
        child: form,
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
