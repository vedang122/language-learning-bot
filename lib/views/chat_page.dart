import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:math';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:language_voice_bot/service/ai_service.dart';
import '../controller/state_controller.dart';
import 'package:language_voice_bot/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:language_voice_bot/models/message.dart' as app_message;

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _author = const types.User(id: 'author');
  final _assistant = const types.User(id: 'assistant');
  final List<types.Message> _messages = [];

  @override
  void initState() {
    var controller = context.read<StateController>();
    for (app_message.Message message in controller.messages) {
      _addMessage(message);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _author,
      ),
    );
  }

  void _addMessage(app_message.Message message) {
    setState(() {
      _messages.insert(
        0,
        types.TextMessage(
          author: message.isAssistant() ? _assistant : _author,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: randomString(),
          text: message.content,
          metadata: {"translation": message.contentTranslation},
        ),
      );
    });
  }

  void _handleSendPressed(types.PartialText message) {
    var controller = context.read<StateController>();
    app_message.Message userMessage = app_message.Message(
      content: message.text,
      type: MessageType.author,
      contentTranslation: "",
      possibleReply: "",
      possibleReplyTranslation: "",
    );
    controller.addMessage(userMessage);
    _addMessage(userMessage);
    AIService().request(controller).then(
      (app_message.Message message) {
        _addMessage(message);
        controller.addMessage(message);
      },
    );
  }
}
