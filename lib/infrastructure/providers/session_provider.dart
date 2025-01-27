import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {


  List _sessions = [];
  List get sessions => _sessions;

  Future<void> loadExercises() async {
    // GetExercisesQuery query = GetExercisesQuery();
    // _sessions = await getExercisesQueryHandler.invoke(query);
    // notifyListeners();
  }

}