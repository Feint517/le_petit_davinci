import 'package:flutter/material.dart';

class CustomShadowStyle {
  static List<BoxShadow> customCircleShadows({
    required Color color,
    double offsetX = 4,
    double offsetY = 3,
    double alpha = 0.3,
  }) => [
    BoxShadow(
      color: Color.alphaBlend(Colors.black.withValues(alpha: alpha), color),
      spreadRadius: 2,
      blurRadius: 0,
      offset: Offset(offsetX, offsetY),
    ),
  ];
}
