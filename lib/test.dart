import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/misc/chat_bubble.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Test Screen')),
      body: Center(
        child: ChatBubble(
          width: 250,
          bubbleColor: AppColors.primary.withValues(alpha: 0.7),
          borderColor: AppColors.accent,
          borderWidth: 1,
          child: const Text(
            'This is a test screen with a long',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}