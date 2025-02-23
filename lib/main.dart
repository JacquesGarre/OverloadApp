import 'package:flutter/material.dart';
import 'package:overload/infrastructure/providers/user_provider.dart';
import 'package:overload/infrastructure/user_interface/layout/app.dart';
import 'package:overload/infrastructure/dependency_injection.dart';
import 'package:overload/infrastructure/providers/exercise_provider.dart';
import 'package:overload/infrastructure/providers/session_provider.dart';
import 'package:overload/infrastructure/providers/workout_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await setupContainer();
  await container<UserProvider>().loadUser();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => container<ExerciseProvider>()),
        ChangeNotifierProvider(create: (_) => container<WorkoutProvider>()),
        ChangeNotifierProvider(create: (_) => container<SessionProvider>()),
        ChangeNotifierProvider(create: (_) => container<UserProvider>()),
      ],
      child: const App(),
    ),
  );
}
