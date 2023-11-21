import 'package:flutter/material.dart';
import 'package:language_voice_bot/modals/chat_message.dart';
import 'package:language_voice_bot/utils/constants.dart';

class MessagesListView extends StatelessWidget {
  List<ChatMessage> messages;
  MessagesListView(this.messages, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Align(
                alignment: (messages[index].messageType == MessageType.receiver
                    ? Alignment.topLeft
                    : Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (messages[index].messageType == MessageType.receiver
                        ? Colors.grey.shade200
                        : Colors.blue[200]),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    messages[index].messageContent,
                    style: const TextStyle(fontSize: 15),
                  ),
                )));
      },
    );
  }
}
