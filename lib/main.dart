import 'package:flutter/material.dart';
import 'package:overload/app.dart';
import 'package:overload/dependency_injection.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupContainer();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => container<ExerciseProvider>(),
        ),
      ],
      child: const App(),
    ),
  );
}
