import 'dart:convert';

import 'package:language_voice_bot/models/message.dart';
import 'package:language_voice_bot/utils/constants.dart';

class AIResponse {
  final Message response;
  final int tokens;

  const AIResponse({
    required this.response,
    required this.tokens,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      response: Message.fromJson(
        jsonDecode(json['body']['response']) as Map<String, dynamic>,
        MessageType.assistant,
      ),
      tokens: json['body']['tokens'] as int,
    );
  }
}
