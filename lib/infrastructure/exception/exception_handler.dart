import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/exercise/exception/duplicate_exercise_unit_exception.dart';
import 'package:overload/domain/exercise/exception/exercise_already_exists_exception.dart';
import 'package:overload/domain/exercise/exception/exercise_name_too_long_exception.dart';
import 'package:overload/domain/exercise/exception/exercise_not_found_exception.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_id_exception.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_name_exception.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_unit_exception.dart';
import 'package:overload/domain/user/exception/invalid_age_exception.dart';
import 'package:overload/domain/user/exception/invalid_weight_exception.dart';
import 'package:overload/domain/user/exception/user_already_exists_exception.dart';
import 'package:overload/domain/user/exception/username_cannot_be_empty_exception.dart';
import 'package:overload/domain/user/exception/username_too_long_exception.dart';
import 'package:overload/domain/shared/exception/notes_too_long_exception.dart';
import 'package:overload/domain/workout/exception/workout_already_exists_exception.dart';
import 'package:overload/domain/workout/exception/workout_exercise_required_exception.dart';
import 'package:overload/domain/workout/exception/workout_name_too_long_exception.dart';
import 'package:overload/domain/workout/exception/workout_not_found_exception.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class ExceptionHandler {
  static final ExceptionHandler _instance = ExceptionHandler._internal();

  factory ExceptionHandler() => _instance;

  ExceptionHandler._internal();

  void handleException(BuildContext context, dynamic exception) {
    String errorMessage = _getErrorMessage(exception);
    Logger().e(exception);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(
            color: AppColorScheme.onError,
          ),
        ),
        backgroundColor: AppColorScheme.error,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _getErrorMessage(dynamic exception) {
    return switch (exception) {
      DuplicateExerciseUnitException _ =>
        'This exercise cannot have more than once the same unit',
      ExerciseAlreadyExistsException _ => 'This exercise already exists',
      ExerciseNotFoundException _ => 'Exercise not found',
      InvalidExerciseIdException _ => 'Invalid exercise id. Please try again',
      InvalidExerciseNameException _ => 'Exercise name is not valid',
      InvalidExerciseUnitException _ => 'Exercise unit is not valid',
      WorkoutExerciseRequiredException _ => 'At least one exercise is required',
      WorkoutAlreadyExistsException _ => 'This workout already exists',
      WorkoutNotFoundException _ => 'Workout not found',
      ExerciseNameTooLongException _ =>
        'Exercise name cannot exceed 30 characters length',
      WorkoutNameTooLongException _ =>
        'Workout name cannot exceed 50 characters length',
      NotesTooLongException _ => 'Notes cannot exceed 500 characters length',
      UsernameCannotBeEmptyException _ => 'Username cannot be empty',
      UsernameTooLongException _ =>
        'Username cannot exceed 30 characters length',
      InvalidAgeException _ => 'Invalid age',
      InvalidWeightException _ => 'Invalid weight',
      UserAlreadyExistsException _ => 'User already exists',
      _ => 'An unknown error occurred',
    };
  }
}
