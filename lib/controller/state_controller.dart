import 'package:flutter/material.dart';
import 'package:language_voice_bot/models/language.dart';
import 'package:language_voice_bot/models/message.dart';
import 'package:language_voice_bot/utils/constants.dart';

class StateController extends ChangeNotifier {
  Language language;
  List<Message> messages;

  StateController({required this.language, required this.messages});

  void addMessage(String text, String possibleReply, MessageType messageType) {
    debugPrint("Added meesage with notifying: { $text, ${messageType.name}}");
    messages.add(Message(
        content: text, possibleReply: possibleReply, type: messageType));
    notifyListeners();
  }

  void addMessageWithoutNotifying(
      String text, String possibleReply, MessageType messageType) {
    debugPrint(
        "Added meesage without notifying: { $text, ${messageType.name}}");
    messages.add(Message(
        content: text, possibleReply: possibleReply, type: messageType));
  }

  List<Message> getMessages() {
    return messages;
  }
}
