import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/exercises/controllers/exercises_controller.dart';
import 'package:le_petit_davinci/features/exercises/models/solve_equation_exercise_model.dart';

class SolveEquationView extends StatelessWidget {
  final SolveEquationExercise exercise;
  const SolveEquationView({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    // Use GetX to rebuild the options when the selection changes
    final controller = Get.find<ExercisesController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          exercise.equation,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: List.generate(exercise.options.length, (index) {
            return Obx(() => ChoiceChip(
                  label: Text(exercise.options[index].toString(), style: const TextStyle(fontSize: 24)),
                  selected: exercise.selectedIndex == index,
                  onSelected: (isSelected) {
                    if (isSelected) {
                      // Update the model's state, not the controller's
                      exercise.selectOption(index);
                      // Trigger a rebuild of this widget
                      controller.update(); 
                    }
                  },
                ));
          }),
        ),
      ],
    );
  }
}