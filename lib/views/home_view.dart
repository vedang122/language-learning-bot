import 'package:flutter/material.dart';
import 'package:language_voice_bot/views/bottom_messaging_bar_view.dart';
import 'package:language_voice_bot/views/messages_list_view.dart';

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
  Widget build(BuildContext context) {
    debugPrint('building MyHomePage');
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
