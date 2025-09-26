import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/widgets/misc/animated_mascot.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';

/// A feedback widget that shows a mascot with appropriate animation and message
/// based on whether the user's answer was correct or incorrect
class MascotFeedbackWidget extends StatelessWidget {
  const MascotFeedbackWidget({
    super.key,
    required this.isCorrect,
    this.correctAnswer,
    this.onContinue,
  });

  final bool isCorrect;
  final String? correctAnswer;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xFFd7f9e9) : const Color(0xFFfde2e4),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mascot with appropriate animation and message
          AnimatedMascot(
            mascotSize: 120,
            bubbleText: _getFeedbackMessage(),
            bubbleWidth: 250,
            bubbleColor: isCorrect ? Colors.green : Colors.red,
            animationType:
                isCorrect ? MascotAnimationType.happy : MascotAnimationType.sad,
            autoPlay: true,
          ),

          const SizedBox(height: 20),

          // Correct answer display (only for incorrect answers)
          if (!isCorrect && correctAnswer != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    'The correct answer is:',
                    style: Get.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.red.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    correctAnswer!,
                    style: Get.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Continue button
          CustomButton(
            label: 'Continue',
            onPressed: onContinue,
            variant: isCorrect ? ButtonVariant.primary : ButtonVariant.warning,
          ),
        ],
      ),
    );
  }

  String _getFeedbackMessage() {
    if (isCorrect) {
      final messages = [
        'Excellent! 🎉',
        'Great job! ⭐',
        'Perfect! 🌟',
        'Well done! 👏',
        'Amazing! 🚀',
        'Fantastic! 🎊',
        'Outstanding! 🏆',
        'Brilliant! ✨',
      ];
      return messages[DateTime.now().millisecond % messages.length];
    } else {
      final messages = [
        'Not quite right... 😔',
        'Try again! 💪',
        'Don\'t give up! 🌱',
        'You can do it! 💫',
        'Keep trying! 🔄',
        'Almost there! 🎯',
        'One more time! 🚀',
        'You\'ve got this! 💪',
      ];
      return messages[DateTime.now().millisecond % messages.length];
    }
  }
}
