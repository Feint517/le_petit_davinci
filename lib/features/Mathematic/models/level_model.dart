import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';

class LevelModel {
  LevelModel({
    required this.title,
    required this.levelType,
    required this.levelStatus,
    this.content,
  });

  final String title;
  final LevelType levelType;
  final LevelStatus levelStatus;
  final Widget? content;
}
