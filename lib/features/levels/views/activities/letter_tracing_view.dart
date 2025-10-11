import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activities/letter_tracing_activity.dart';
import 'package:le_petit_davinci/features/levels/widgets/letter_tracing_canvas.dart';

class LetterTracingView extends StatelessWidget {
  const LetterTracingView({super.key, required this.activity});

  final LetterTracingActivity activity;

  @override
  Widget build(BuildContext context) {
    final letter = activity.letter.isNotEmpty ? activity.letter : 'A';

    // Initialize mascot when the view is built
    final messages =
        [
          'Super! Prêt à tracer la lettre $letter?',
          activity.prompt ?? 'Trace la lettre $letter avec ton doigt!',
        ].where((message) => message.isNotEmpty).toList();

    activity.initializeMascot(messages);

    return _buildTracingCanvas();
  }

  Widget _buildTracingCanvas() {
    final letter = activity.letter.isNotEmpty ? activity.letter : 'A';
    return LetterTracingCanvas(
      letter: letter,
      onTracingCompleted: () {
        activity.markTracingAsCompleted();
      },
    );
  }
}
