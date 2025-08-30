import 'package:flutter/material.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';

class SectionData {
  SectionData({
    required this.color,
    required this.level,
    required this.section,
    required this.title,
    required this.levels,
  });

  final Color color;
  final int level;
  final int section;
  final String title;
  final List<Level> levels;
}
