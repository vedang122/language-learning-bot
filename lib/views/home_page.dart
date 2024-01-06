import 'package:flutter/material.dart';
import 'package:language_voice_bot/views/configuration_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: ConfigurationPage(),
      );
}
