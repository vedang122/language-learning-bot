import 'package:flutter/material.dart';
import 'package:language_voice_bot/controller/state_controller.dart';
import 'package:language_voice_bot/service/ai_service.dart';
import 'package:language_voice_bot/utils/constants.dart';
import 'package:language_voice_bot/views/bottom_messaging_bar_view.dart';
import 'package:language_voice_bot/views/messages_list_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    var controller = context.read<StateController>();
    fetchAIResponse(controller.messages)
                  .then((aiResponse) => controller.addMessage(
                        aiResponse.response.message,
                        aiResponse.response.possibleReply,
                        MessageType.assistant,
                      ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    debugPrint('Building MyHomePage');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Learning Companian"),
      ),
      body: Stack(
        children: <Widget>[
          const MessagesListView(),
          Align(
            alignment: Alignment.bottomLeft,
            child: BottomMessagingBar(),
          ),
        ],
      ),
    );
  }
}
