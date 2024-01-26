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
  OverlayEntry? _popupEntry;

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
        onMessageDoubleTap: _handleMessageDoubleTap,
        onMessageLongPress: _handleMessageLongPress,
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
          metadata: {
            "translation": message.contentTranslation,
            "possible_reply": message.possibleReply,
            "possible_reply_translation": message.possibleReplyTranslation,
          },
        ),
      );
    });
  }

  void _handleMessageLongPress(
    BuildContext context,
    types.Message message,
  ) async {
    if (message is types.TextMessage) {
      if (message.metadata?["possible_reply"] != "") {
        showPopup(
          context,
          message.metadata?["possible_reply"] +
              "\n(" +
              message.metadata?["possible_reply_translation"] +
              ")",
        );
      }
    } else {
      throw Exception("Only text messages are supported for single tap!");
    }
  }

  void _handleMessageDoubleTap(
    BuildContext context,
    types.Message message,
  ) async {
    if (message is types.TextMessage) {
      if (message.metadata?["translation"] != "") {
        showPopup(
          context,
          message.metadata?["translation"],
        );
      }
    } else {
      throw Exception("Only text messages are supported for long press!");
    }
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

  void showPopup(BuildContext context, String popupMessage) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _popupEntry = createPopup(context, position, size, popupMessage);
    Overlay.of(context).insert(_popupEntry!);
  }

  OverlayEntry createPopup(
      BuildContext context, Offset position, Size size, String popupMessage) {
    return OverlayEntry(
      builder: (context) => Stack(
        children: <Widget>[
          GestureDetector(
            onTap:
                dismissPopup, // Dismisses popup when user taps anywhere on screen
            behavior: HitTestBehavior
                .opaque, // Ensures the gesture detector covers the entire screen
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy + size.height,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xff6f61e8),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.grey,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Text(
                  popupMessage,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dismissPopup() {
    _popupEntry?.remove();
    _popupEntry = null;
  }
}
