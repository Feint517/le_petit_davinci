import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/activities/solve_equation_activity.dart';

class SolveEquationView extends StatelessWidget {
  const SolveEquationView({super.key, required this.activity});

  final SolveEquationActivity activity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          activity.equation,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: List.generate(activity.options.length, (index) {
            return Obx(
              () => ChoiceChip(
                label: Text(
                  activity.options[index].toString(),
                  style: const TextStyle(fontSize: 24),
                ),
                selected: activity.selectedIndex == index,
                onSelected: (isSelected) {
                  if (isSelected) {
                    // Update the model's state, not the controller's
                    activity.selectOption(index);
                  }
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
