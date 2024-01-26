import 'dart:convert';

import 'package:language_voice_bot/controller/state_controller.dart';
import 'package:language_voice_bot/models/ai_response.dart';
import 'package:http/http.dart' as http;
import 'package:language_voice_bot/models/message.dart';

class AIService {
  Future<Message> request(StateController stateController) async {
    Map<String, dynamic> queryParameters = {
      'languageToPractise': stateController.languageToPractise,
      'languageUserKnow': stateController.languageUserKnow,
      'languageLevel': stateController.languageLevel,
      'situation': stateController.situation,
      'messages': []
    };
    for (var message in stateController.messages) {
      queryParameters['messages']?.add(
        {
          'content': message.content,
          'role': message.type.name,
        },
      );
    }
    final response = await http
        .post(
      Uri.https('v7rnmmqt00.execute-api.eu-west-1.amazonaws.com', 'DEV'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(queryParameters),
    )
        .timeout(const Duration(seconds: 30), onTimeout: () {
      throw Exception('Server timed out');
    });

    if (response.statusCode == 200) {
      return AIResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      ).response;
    } else {
      throw Exception('Failed to load AI Response');
    }
  }
}
