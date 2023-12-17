import 'package:flutter/material.dart';
import 'package:language_voice_bot/controller/state_controller.dart';
import 'package:language_voice_bot/service/ai_service.dart';
import 'package:language_voice_bot/utils/constants.dart';
import 'package:provider/provider.dart';

class BottomMessagingBar extends StatelessWidget {
  BottomMessagingBar({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint("Building Bottom bar");
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
              controller: textEditingController,
              decoration: const InputDecoration(
                hintText: "Write message...",
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              var controller = context.read<StateController>();
              controller.addMessage(
                textEditingController.text,
                "",
                MessageType.user,
              );
              textEditingController.clear();
              fetchAIResponse(controller.messages).then(
                (aiResponse) => controller.addMessage(
                  aiResponse.response.message,
                  aiResponse.response.possibleReply,
                  MessageType.assistant,
                ),
              );
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
