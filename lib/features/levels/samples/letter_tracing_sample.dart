import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activities/drawing_activity.dart';

/// Sample usage of the LetterTracingActivity
/// This demonstrates how to create letter tracing activities for different letters
class LetterTracingSample {
  /// Create a letter tracing activity for letter A
  static LetterTracingActivity createLetterA() {
    return LetterTracingActivity(
      letter: 'A',
      prompt: 'Trace la lettre A! Commence par le bas à gauche.',
    );
  }

  /// Create a letter tracing activity for letter B
  static LetterTracingActivity createLetterB() {
    return LetterTracingActivity(
      letter: 'B',
      prompt: 'Trace la lettre B! Dessine deux boucles.',
    );
  }

  /// Create a letter tracing activity for letter C
  static LetterTracingActivity createLetterC() {
    return LetterTracingActivity(
      letter: 'C',
      prompt: 'Trace la lettre C! Dessine un demi-cercle.',
    );
  }

  /// Create a letter tracing activity for any letter
  static LetterTracingActivity createLetter(String letter) {
    return LetterTracingActivity(
      letter: letter.toUpperCase(),
      prompt: 'Trace la lettre $letter! Suis le chemin avec ton doigt.',
    );
  }

  /// Create a series of letter tracing activities for the alphabet
  static List<LetterTracingActivity> createAlphabetSeries() {
    List<String> alphabet = [
      'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
      'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
      'U', 'V', 'W', 'X', 'Y', 'Z'
    ];

    return alphabet.map((letter) => createLetter(letter)).toList();
  }

  /// Create letter tracing activities for vowels only
  static List<LetterTracingActivity> createVowelsSeries() {
    List<String> vowels = ['A', 'E', 'I', 'O', 'U'];
    return vowels.map((letter) => createLetter(letter)).toList();
  }

  /// Create letter tracing activities for consonants only
  static List<LetterTracingActivity> createConsonantsSeries() {
    List<String> consonants = [
      'B', 'C', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M',
      'N', 'P', 'Q', 'R', 'S', 'T', 'V', 'W', 'X', 'Y', 'Z'
    ];
    return consonants.map((letter) => createLetter(letter)).toList();
  }
}

/// Example usage in a lesson or level
class LetterTracingExample extends StatelessWidget {
  const LetterTracingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Letter Tracing Example'),
      ),
      body: Column(
        children: [
          // Example: Single letter tracing
          Expanded(
            child: LetterTracingSample.createLetterA().build(context),
          ),
          
          // Example: Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to previous letter
                  },
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to next letter
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
