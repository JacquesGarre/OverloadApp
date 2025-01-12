import 'package:flutter/material.dart';
import 'package:overload/domain/exercise/exception/duplicate_exercise_unit_exception.dart';
import 'package:overload/domain/exercise/exception/exercise_already_exists_exception.dart';
import 'package:overload/domain/exercise/exception/exercise_not_found_exception.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_id_exception.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_name_exception.dart';
import 'package:overload/domain/exercise/exception/invalid_exercise_unit_exception.dart';
import 'package:overload/infrastructure/theme/app_color_scheme.dart';

class ExceptionHandler {
  static final ExceptionHandler _instance = ExceptionHandler._internal();

  factory ExceptionHandler() => _instance;

  ExceptionHandler._internal();

  void handleException(BuildContext context, dynamic exception) {
    String errorMessage = _getErrorMessage(exception);
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
    if (exception is DuplicateExerciseUnitException) {
      return 'This exercise cannot have more than once the same unit';
    }
    if (exception is ExerciseAlreadyExistsException) {
      return 'This exercise already exists';
    }
    if (exception is ExerciseNotFoundException) {
      return 'Exercise not found';
    }
    if (exception is InvalidExerciseIdException) {
      return 'Invalid exercise id. Please try again';
    }
    if (exception is InvalidExerciseNameException) {
      return 'Exercise name is not valid';
    }
    if (exception is InvalidExerciseUnitException) {
      return 'Exercise unit is not valid';
    }
    return 'An unexpected error occurred. Please try again';
  }
}
