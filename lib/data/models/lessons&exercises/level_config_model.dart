import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';

class LevelConfig {
  LevelConfig({
    required this.number,
    this.title,
    required this.type,
    required this.status,
    this.onTap,
  });

  final int number;
  final String? title;
  final LevelType type;
  final LevelStatus status;
  final VoidCallback? onTap;
}
