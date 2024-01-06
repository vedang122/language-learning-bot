import 'dart:convert';

import 'package:flutter/material.dart';
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
    debugPrint("Response message: ${json['response']}");
    //Sometimes model doesn't bide with json format we asked it to send response in, so additional check. Look into this later.
    return AIResponse(
      response: Message.fromJson(
        jsonDecode(json['response']) as Map<String, dynamic>,
        MessageType.assistant,
      ),
      tokens: json['tokens'] as int,
    );
  }
}
