import 'package:language_voice_bot/utils/constants.dart';

class Message {
  String content = "";
  String contentTranslation = "";
  MessageType type;
  String possibleReply = "";
  String possibleReplyTranslation = "";
  Message({
    required this.content,
    required this.type,
    required this.contentTranslation,
    required this.possibleReply,
    required this.possibleReplyTranslation,
  });

  bool isSender() {
    return type == MessageType.author;
  }

  bool isAssistant() {
    return type == MessageType.assistant;
  }

  factory Message.fromJson(Map<String, dynamic> json, MessageType messageType) {
    return Message(
      content: json['assistant']['message'],
      contentTranslation: json['assistant']['translation'],
      possibleReply: json['possible_reply']['message'],
      possibleReplyTranslation: json['possible_reply']['translation'],
      type: messageType,
    );
  }
}
