import 'package:flutter/material.dart';
import 'package:language_voice_bot/controller/state_controller.dart';
import 'package:language_voice_bot/models/chat_message.dart';
import 'package:provider/provider.dart';

/// Given a list of messages, it shows all the messages on the screen.
/// Color and Alignment are alternate based on sender & receiver.
class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key});

  Alignment getMessageAlignment(ChatMessage message) {
    return message.isReceiver() ? Alignment.topLeft : Alignment.topRight;
  }

  Color? getMessageColor(ChatMessage message) {
    return message.isReceiver() ? Colors.grey.shade200 : Colors.blue[200];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(
      builder: (context, contoller, child) {
        final messages = contoller.messages;
        return ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 10, bottom: 10),
              child: Align(
                alignment: getMessageAlignment(messages[index]),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: getMessageColor(messages[index]),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    messages[index].messageContent,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
