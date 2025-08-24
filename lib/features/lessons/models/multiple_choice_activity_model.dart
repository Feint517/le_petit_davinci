import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';

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
  void submitAnswer() =>
      isCompleted.value = true; // For now, completion is just submitting.

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Multiple Choice Activity: $instruction'));
  }
}

class SelectableOption {
  final String label;
  final String imagePath;
  SelectableOption({required this.label, required this.imagePath});
}
