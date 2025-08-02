import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';

class DrawingActivityView extends StatelessWidget {
  const DrawingActivityView({super.key, required this.activity});
  final DrawingActivity activity;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            activity.prompt,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(20),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Drawing Canvas Here')),
            ),
          ),
          const Gap(20),
          ElevatedButton(
            onPressed: () {
              // When the user is done, they press this button to complete the activity.
              activity.isCompleted.value = true;
            },
            child: const Text('I\'m Done!'),
          ),
        ],
      ),
    );
  }
}
