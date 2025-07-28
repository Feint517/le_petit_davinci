import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';

class Level {
  Level({
    this.number,
    // required this.title,
    required this.levelType,
    required this.levelStatus,
    this.onTap,
  });

  final int? number;
  // final String title;
  final LevelType levelType;
  final LevelStatus levelStatus;
  final VoidCallback? onTap;
}
