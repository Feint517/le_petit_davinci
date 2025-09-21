import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';

class ArrangeNumbersActivity extends Activity {
  final List<int> numbers;
  final bool isAscending;
  final String instruction;
  final int? maxNumber;
  final int? minNumber;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  ArrangeNumbersActivity({
    required this.numbers,
    required this.isAscending,
    required this.instruction,
    this.maxNumber,
    this.minNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Arrange Numbers Activity: $instruction'));
  }
}
