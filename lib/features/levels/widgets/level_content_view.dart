import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';

class LevelContentView extends GetView<LevelController> {
  const LevelContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.hasError.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error loading level',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                controller.errorMessage.value ?? 'Unknown error',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.retry(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }
      // Build the current activity directly
      final currentIndex = controller.currentIndex.value;
      final currentActivity = controller.levelSet.activities[currentIndex];
      return currentActivity.build(context);
    });
  }
}
