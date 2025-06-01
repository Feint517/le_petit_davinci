import 'package:flutter/material.dart';

class BadgeData {
  final String assetPath;
  final String name;
  final bool isEarned;

  const BadgeData({
    required this.assetPath,
    required this.name,
    this.isEarned = false,
  });
}

class SubjectTitleData {
  final String titleName;
  final bool isAchieved;

  const SubjectTitleData({
    required this.titleName,
    this.isAchieved = false,
  });
}