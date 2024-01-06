import 'package:flutter/material.dart';
import 'package:language_voice_bot/models/message.dart';
import 'package:language_voice_bot/service/ai_service.dart';

class StateController extends ChangeNotifier {
  late String languageToPractise;

  late String languageUserKnow;

  late String languageLevel;

  late String situation;

  List<Message> messages = List.empty(growable: true);

  final AIService aiService = AIService();

  // Future<Message> getAIResponse() async {
  //   try {
  //     var aiResponse = await aiService.request(this);
  //     Message message = Message(
  //         content: aiResponse.response.message,
  //         type: MessageType.assistant,
  //         contentTranslation: aiResponse.response.messageTranslation,
  //         possibleReply: aiResponse.response.possibleReply,
  //         possibleReplyTranslation:
  //             aiResponse.response.possibleReplyTranslation);
  //     addMessage(message);
  //     return message;
  //   } catch (error) {
  //     throw Exception(
  //         "Seems like Assistant doesn't want to reply back: $error");
  //   }
  // }

  void addMessage(Message message) {
    messages.add(message);
  }
}
