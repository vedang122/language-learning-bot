import 'dart:convert';

import 'package:flutter/material.dart';
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
    debugPrint("Inside Future!");
    final response = await http
        .post(
      Uri.parse('http://127.0.0.1:5000'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(queryParameters),
    )
        .timeout(const Duration(seconds: 30), onTimeout: () {
      throw Exception('Server timed out');
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return AIResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      ).response;
    } else {
      debugPrint(
          "Thrown Error while fetching data from server: ${response.toString()}");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load AI Response');
    }
  }
}
