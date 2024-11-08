import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чаты',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
          ),),
      ),
      body: const Center(child: Text('Страница чата')),
    );
  }
}
