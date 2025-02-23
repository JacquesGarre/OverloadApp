import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:overload/domain/user/user.dart';
import 'package:overload/domain/workout/exception/workout_generation_failed_exception.dart';
import 'package:overload/domain/workout/workout.dart';
import 'package:overload/domain/workout/workout_generator_interface.dart';
import 'package:overload/infrastructure/services/exception/environment_variable_not_found_exception.dart';
import 'package:http/http.dart' as http;

class OpenaiWorkoutGenerator implements WorkoutGeneratorInterface {

  @override
  Future<List<Workout>> generateFromUser(User user) async {
    Map<String, dynamic> userJson = user.toJson();
    userJson.remove("id");
    userJson.remove("username");
    Logger().i("[OpenaiWorkoutGenerator] Generating workouts for user preferences : ${jsonEncode(userJson)}");
    String response = await getAssistantResponse(jsonEncode(userJson));
    Map<String, dynamic> jsonResponse = jsonDecode(response);
    List<Workout> workouts = [];
    for(Map<String, dynamic> jsonWorkout in jsonResponse["workouts"]) {
      Logger().e(jsonWorkout);
      Workout workout = Workout.generateFromJson(jsonWorkout);
      workouts.add(workout);
    }
    return workouts;
  }

  Map<String, String> headers() {
    String? apiKey = dotenv.env['OPENAI_API_KEY'];
    if (apiKey == null) {
      throw EnvironmentVariableNotFoundException();
    }
    return {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
      "OpenAI-Beta": "assistants=v2", 
    };
  }

  Future<String> getAssistantResponse(String userMessage) async {
    String? baseUrl = dotenv.env['OPENAI_API_BASE_URL'];
    if (baseUrl == null) {
      throw EnvironmentVariableNotFoundException();
    }
    String? apiKey = dotenv.env['OPENAI_API_KEY'];
    if (apiKey == null) {
      throw EnvironmentVariableNotFoundException();
    }
    String? assistantId = dotenv.env['OPENAI_ASSISTANT_ID'];
    if (assistantId == null) {
      throw EnvironmentVariableNotFoundException();
    }
    try {
      // Step 1: Create a new thread
      Logger().i("[OpenaiWorkoutGenerator] Creating thread...");
      final threadResponse = await http.post(
        Uri.parse("$baseUrl/threads"),
        headers: headers(),
      );
      if (threadResponse.statusCode != 200) {
        Logger().e("[OpenaiWorkoutGenerator] Error creating thread: ${threadResponse.body}") ;
        throw WorkoutGenerationFailedException();
      }
      final threadId = jsonDecode(threadResponse.body)['id'];

      // Step 2: Send the user message to the thread
      Logger().i("[OpenaiWorkoutGenerator] Sending message...");
      final messageResponse = await http.post(
        Uri.parse("$baseUrl/threads/$threadId/messages"),
        headers: headers(),
        body: jsonEncode({
          "role": "user",
          "content": userMessage,
        }),
      );
      if (messageResponse.statusCode != 200) {
        Logger().e("[OpenaiWorkoutGenerator] Error sending message: ${messageResponse.body}");
        throw WorkoutGenerationFailedException();
      }

      // Step 3: Run the assistant
      Logger().i("[OpenaiWorkoutGenerator] Running assistant...");
      final runResponse = await http.post(
        Uri.parse("$baseUrl/threads/$threadId/runs"),
        headers: headers(),
        body: jsonEncode({
          "assistant_id": assistantId,
        }),
      );
      if (runResponse.statusCode != 200) {
        Logger().e("[OpenaiWorkoutGenerator] Error running assistant: ${runResponse.body}");
        throw WorkoutGenerationFailedException();
      }
      final runId = jsonDecode(runResponse.body)['id'];

      // Step 4: Poll for completion
      Logger().i("[OpenaiWorkoutGenerator] Polling for completion...");
      String status = "queued";
      while (status == "queued" || status == "in_progress") {
        await Future.delayed(const Duration(seconds: 2));
        final runStatusResponse = await http.get(
          Uri.parse("$baseUrl/threads/$threadId/runs/$runId"),
          headers: headers(),
        );
        if (runStatusResponse.statusCode != 200) {
          Logger().e("[OpenaiWorkoutGenerator] Error checking run status: ${runStatusResponse.body}");
          throw WorkoutGenerationFailedException();
        }
        final runStatus = jsonDecode(runStatusResponse.body);
        status = runStatus["status"];
      }

      // Step 5: Retrieve the assistant’s response
      Logger().i("[OpenaiWorkoutGenerator] Retrieving assistant's response...");
      final messagesResponse = await http.get(
        Uri.parse("$baseUrl/threads/$threadId/messages"),
        headers: headers(),
      );
      if (messagesResponse.statusCode != 200) {
        Logger().e("[OpenaiWorkoutGenerator] Error retrieving messages: ${messagesResponse.body}");
        throw WorkoutGenerationFailedException();
      }
      final messages = jsonDecode(messagesResponse.body);
      final assistantMessage = messages["data"].first["content"].first["text"]["value"];
      return assistantMessage;
    } catch (e) {
      rethrow;
    }
  }
}
