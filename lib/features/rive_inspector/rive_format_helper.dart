import 'package:flutter/material.dart';

class RiveFormatHelper {
  static void showFormatInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Rive Format Information'),
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'File Format Issues:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  Text('• .rev files are Rive\'s binary format'),
                  Text('• .riv files are JSON-based format'),
                  Text('• Flutter Rive package works best with .riv files'),
                  SizedBox(height: 16),
                  Text(
                    'Solutions:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  Text('1. Open your .rev files in Rive Editor'),
                  Text('2. Export them as .riv files'),
                  Text('3. Replace the .rev files with .riv files'),
                  SizedBox(height: 16),
                  Text(
                    'Alternative:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Use RiveAnimation.asset() directly in your code with the .riv files that work.',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Got it'),
              ),
            ],
          ),
    );
  }

  static List<String> getWorkingFiles() {
    return [
      'assets/animations/rive/talking_bear.riv',
      'assets/animations/rive/happy_bear.riv',
      'assets/animations/rive/sad_bear.riv',
      'assets/animations/rive/subjects.riv', // This one should work
    ];
  }

  static List<String> getProblematicFiles() {
    return [
      'assets/animations/rive/boy1.rev',
      'assets/animations/rive/boy2.rev',
      'assets/animations/rive/girl1.rev',
      'assets/animations/rive/girl2.rev',
      'assets/animations/rive/games.rev',
      'assets/animations/rive/sbjects.rev',
    ];
  }
}
