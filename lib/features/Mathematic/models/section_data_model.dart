import 'package:flutter/material.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';

class SectionData {
  SectionData({
    required this.color,
    required this.etapa,
    required this.seccion,
    required this.title,
    required this.levels,
  });

  final Color color;
  final int etapa;
  final int seccion;
  final String title;
  final List<Level> levels;
}
