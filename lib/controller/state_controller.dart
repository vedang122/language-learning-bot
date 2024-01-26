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

  void addMessage(Message message) {
    messages.add(message);
  }
}
