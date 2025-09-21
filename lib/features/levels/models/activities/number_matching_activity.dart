import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/models/number_matching_models.dart';

class NumberMatchingActivity extends Activity {
  final List<NumberMatchingItem> items;
  final String instruction;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  NumberMatchingActivity({required this.items, required this.instruction});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Number Matching Activity: $instruction'));
  }
}
