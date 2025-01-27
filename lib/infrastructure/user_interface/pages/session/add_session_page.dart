import 'package:flutter/material.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/widgets/exercise/exercise_form_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/shared/page_widget.dart';
import 'package:provider/provider.dart';

class AddSessionPage extends StatelessWidget {
  const AddSessionPage({super.key});

  static const String title = 'New session';

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(
      context,
      listen: false,
    );
    return PageWidget(
      title: title,
      child: Text("New session"),
      
      //  ExerciseFormWidget(
      //   onSubmit: (formData) async {
      //     try {
      //       await sessionProvider.addExercise(formData);
      //       if (!context.mounted) return;
      //       Navigator.pop(context, true);
      //     } catch (e) {
      //       ExceptionHandler().handleException(context, e);
      //     }
      //   },
      // ),
    );
  }
}
