import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:language_voice_bot/models/ai_response.dart';
import 'package:http/http.dart' as http;
import 'package:language_voice_bot/models/message.dart';
import 'package:language_voice_bot/utils/constants.dart';

Future<AIResponse> fetchAIResponse(List<Message> messages) async {
  Map<String, List<Map<String, dynamic>>> queryParameters = {
    "messages": [],
  };
  for (var message in messages) {
    queryParameters['messages']?.add(
      {
        'content': message.content,
        'role': message.type.name,
      },
    );
    if (message.type == MessageType.assistant) {
      queryParameters['messages']?.last['content'] = jsonEncode(
        {
          'possible_reply': message.possibleReply,
          'response': message.content,
        },
      );
    }
  }
  debugPrint("Inside Future!");
  final response = await http.post(
    Uri.parse('http://127.0.0.1:5000/response'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(queryParameters),
  );
  //final response = await http.get(uri, headers: headers);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AIResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    debugPrint(
        "Thrown Error while fetching data from server: ${response.toString()}");
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load AI Response');
  }
}
