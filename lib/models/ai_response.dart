import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:language_voice_bot/models/ai_message.dart';

class AIResponse {
  final AIMessage response;
  final String role;
  final int tokens;

  const AIResponse({
    required this.response,
    required this.role,
    required this.tokens,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    debugPrint("Response message: ${json['response']}");
    debugPrint("Response role: ${json['role']}");
    //Sometimes model doesn't bide with json format we asked it to send response in, so additional check. Look into this later. 
    if(!json['response'].contains("possible_reply")) {
      return AIResponse(response: AIMessage(message: json['response'], possibleReply: ""), role: json['role'] as String, tokens: json['tokens'] as int);
    }
    return AIResponse(response: AIMessage.fromJson(jsonDecode(json['response']) as Map<String, dynamic>), role: json['role'] as String, tokens: json['tokens'] as int);
  }
}
