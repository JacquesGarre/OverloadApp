import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/layout/app.dart';
import 'package:overload/infrastructure/dependency_injection.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/providers/workout_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupContainer();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => container<ExerciseProvider>()),
        ChangeNotifierProvider(create: (_) => container<WorkoutProvider>()),
        ChangeNotifierProvider(create: (_) => container<SessionProvider>()),
      ],
      child: const App(),
    ),
  );
}
