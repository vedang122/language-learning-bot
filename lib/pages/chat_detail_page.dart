import 'package:flutter/material.dart';
import 'package:language_voice_bot/modals/chat_message.dart';
import 'package:language_voice_bot/utils/constants.dart';
import 'package:language_voice_bot/widgets/messages_list_view.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final _textController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textController.dispose();
    super.dispose();
  }

  List<ChatMessage> _messages = [
    ChatMessage(
        messageContent: "Hello, Will", messageType: MessageType.receiver),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Learning Companian"),
      ),
      body: Stack(
        children: <Widget>[
          MessagesListView(_messages),
          Align(
            alignment: Alignment.bottomLeft,
            child: getBottomMessagingBar(),
          ),
        ],
      ),
    );
  }

  Widget getBottomMessagingBar() {
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                  hintText: "Write message...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _messages.add(
                  ChatMessage(
                      messageContent: _textController.text,
                      messageType: MessageType.sender),
                );
              });
              _textController.clear();
            },
            backgroundColor: Colors.blue,
            elevation: 0,
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
