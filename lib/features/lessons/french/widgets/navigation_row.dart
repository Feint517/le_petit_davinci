import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/french/controllers/alphabet_lesson_controller.dart';

class NavigationRow extends GetView<AlphabetLessonController> {
  const NavigationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: controller.previousLetter,
          icon: const Icon(Icons.arrow_back_ios, size: 16),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.purple),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => controller.toggleLetterExpanded(),
          icon: const Icon(Icons.grid_view, size: 16),
          label: const Text("Retour"),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
            foregroundColor: WidgetStateProperty.all(Colors.black87),
          ),
        ),
        IconButton(
          onPressed: controller.nextLetter,
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.secondary),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
      ],
    );
  }
}
