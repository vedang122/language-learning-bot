import 'package:language_voice_bot/utils/constants.dart';

class ChatMessage {
  String messageContent;
  MessageType messageType;
  ChatMessage({required this.messageContent, required this.messageType});

  bool isSender() {
    return messageType == MessageType.sender;
  }

  bool isReceiver() {
    return messageType == MessageType.receiver;
  }
}
