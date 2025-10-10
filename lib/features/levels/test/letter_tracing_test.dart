import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activities/drawing_activity.dart';

/// Simple test to verify LetterTracingActivity works correctly
class LetterTracingTest extends StatelessWidget {
  const LetterTracingTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Letter Tracing Test'),
      ),
      body: Column(
        children: [
          // Test 1: Normal LetterTracingActivity
          Expanded(
            child: LetterTracingActivity(
              letter: 'A',
              prompt: 'Test tracing letter A',
            ).build(context),
          ),
          
          // Test 2: Backward compatibility DrawingActivity
          Expanded(
            child: DrawingActivity(
              prompt: 'Test backward compatibility',
            ).build(context),
          ),
        ],
      ),
    );
  }
}

/// Test function to verify activity creation
void testLetterTracingActivities() {
  // Test normal creation
  final activity1 = LetterTracingActivity(
    letter: 'B',
    prompt: 'Test B',
  );
  print('Activity 1 letter: ${activity1.letter}');
  print('Activity 1 prompt: ${activity1.prompt}');
  
  // Test backward compatibility
  final activity2 = DrawingActivity(
    prompt: 'Test backward compatibility',
  );
  print('Activity 2 letter: ${activity2.letter}');
  print('Activity 2 prompt: ${activity2.prompt}');
  
  // Test edge cases
  final activity3 = LetterTracingActivity(
    letter: '',
    prompt: 'Empty letter test',
  );
  print('Activity 3 letter: ${activity3.letter}');
  
  final activity4 = LetterTracingActivity(
    letter: 'a', // lowercase
    prompt: 'Lowercase test',
  );
  print('Activity 4 letter: ${activity4.letter}');
}
