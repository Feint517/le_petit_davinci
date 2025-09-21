import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/models/pattern_models.dart';

class ShapePatternActivity extends Activity {
  final List<String> patternImages;
  final List<String> optionImages;
  final int correctIndex;
  final String instruction;
  final PatternType patternType;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  ShapePatternActivity({
    required this.patternImages,
    required this.optionImages,
    required this.correctIndex,
    required this.instruction,
    required this.patternType,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Shape Pattern Activity: $instruction'));
  }
}
