import 'package:flutter/material.dart';

class SubjectData {
  final String label;
  final String imageAssetPath;
  final Color cardColor;
  final VoidCallback? onTap;

  const SubjectData({
    required this.label,
    required this.imageAssetPath,
    required this.cardColor,
    this.onTap,
  });
}
