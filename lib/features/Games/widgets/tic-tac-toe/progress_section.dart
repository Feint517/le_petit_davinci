import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Niveau Maitre 🔥',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'BricolageGrotesque',
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '1542',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'BricolageGrotesque',
                color: AppColors.accent,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: LinearProgressIndicator(
            value: 0.68, // Replace with your value
            backgroundColor: Colors.grey,
            valueColor: const AlwaysStoppedAnimation(AppColors.accent),
            minHeight: 16,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}