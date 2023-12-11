import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:language_voice_bot/models/chat_message.dart';
import 'package:language_voice_bot/utils/constants.dart';

// class StateController {
//   ValueNotifier<List<ChatMessage>> messages = ValueNotifier<List<ChatMessage>>([
//     ChatMessage(messageContent: "Hello!", messageType: MessageType.receiver),
//   ]);

//   void addMessage(String text, MessageType messageType) {
//     messages.value
//         .add(ChatMessage(messageContent: text, messageType: messageType));
//   }

//   void dispose() {
//     messages.dispose();
//   }
// }

class StateController extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(messageContent: "Hello!", messageType: MessageType.receiver),
  ];

  /// An unmodifiable view of the tects in the chat view.
  UnmodifiableListView<ChatMessage> get messages =>
      UnmodifiableListView(_messages);

  void addMessage(String text, MessageType messageType) {
    _messages.add(ChatMessage(messageContent: text, messageType: messageType));
    notifyListeners();
  }
}
