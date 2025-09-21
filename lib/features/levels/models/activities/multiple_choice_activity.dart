import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/models/selectable_option_model.dart';

class MultipleChoiceActivity extends Activity {
  final String instruction;
  final List<SelectableOption> options;
  final List<int> correctIndices;

  final RxList<int> selectedIndices = <int>[].obs;
  final RxBool isIntroCompleted = false.obs;

  MultipleChoiceActivity({
    required this.instruction,
    required this.options,
    required this.correctIndices,
  });

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }

  void markIntroAsCompleted() => isIntroCompleted.value = true;

  void submitAnswer() => markCompleted(); // Use the new unified helper method

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Multiple Choice Activity: $instruction'));
  }
}
