import 'package:language_voice_bot/utils/constants.dart';

class Message {
  String content;
  MessageType type;
  String possibleReply;
  Message({required this.content, required this.type, required this.possibleReply});

  bool isSender() {
    return type == MessageType.user;
  }

  bool isAssistant() {
    return type == MessageType.assistant;
  }

  bool isSystem() {
    return type == MessageType.system;
  }
}
