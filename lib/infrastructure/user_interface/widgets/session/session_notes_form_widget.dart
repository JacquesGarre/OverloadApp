import 'package:flutter/material.dart';
import 'package:overload/domain/session/session.dart';
import 'package:overload/domain/shared/notes.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';
import 'package:provider/provider.dart';

class SessionNotesFormWidget extends StatefulWidget {
  final Session session;

  const SessionNotesFormWidget({super.key, required this.session});

  @override
  SessionNotesFormWidgetState createState() => SessionNotesFormWidgetState();
}

class SessionNotesFormWidgetState extends State<SessionNotesFormWidget> {
  final _notesController = TextEditingController();
  Notes? notes;

  @override
  void initState() {
    super.initState();
    _notesController.text =
        widget.session.notes() != null ? widget.session.notes()!.value() : "";
    notes = widget.session.notes();
  }

  void _updateNotes(String value) async {
    try {
      Notes? notes = Notes.fromString(value);
      SessionProvider sessionProvider =
          Provider.of<SessionProvider>(context, listen: false);
      await sessionProvider.updateSession(widget.session.id(), notes, null, null);
      if (!mounted) return;
    } catch (e) {
      ExceptionHandler().handleException(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Notes"),
        const SizedBox(height: 5.0),
        TextFormField(
            controller: _notesController,
            maxLines: 3,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColorScheme.lightBackground,
              border: const OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            onChanged: (String value) {
              _updateNotes(value);
            }),
      ],
    );
  }
}
