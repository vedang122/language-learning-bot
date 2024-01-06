import 'package:flutter/material.dart';
import 'package:language_voice_bot/models/message.dart';
import 'package:language_voice_bot/service/ai_service.dart';
import 'package:language_voice_bot/views/chat_page.dart';
import 'package:provider/provider.dart';
import 'package:language_voice_bot/controller/state_controller.dart';

class TransitionWidget extends StatefulWidget {
  const TransitionWidget({super.key});

  @override
  TransitionWidgetState createState() => TransitionWidgetState();
}

class TransitionWidgetState extends State<TransitionWidget> {
  @override
  void initState() {
    super.initState();
    _startConversation();
  }

  void _startConversation() async {
    var controller = context.read<StateController>();
    Message message = await AIService().request(controller);
    controller.addMessage(message);
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                  'Tip: You can see translation of assistant messages in language you know by double tapping!'),
            ),
          ],
        ), // Show a loading indicator
      ),
    );
  }
}
