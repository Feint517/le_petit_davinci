import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class CustomShadowStyle {
  static List<BoxShadow> customCircleShadows({
    required Color color,
    bool isDarker = true,
    double offsetX = 4,
    double offsetY = 3,
    double alpha = 0.3,
  }) => [
    BoxShadow(
      color:
          isDarker
              ? Color.alphaBlend(Colors.black.withValues(alpha: alpha), color)
              : color,
      spreadRadius: 2,
      blurRadius: 0,
      offset: Offset(offsetX, offsetY),
    ),
  ];

  static List<BoxShadow> customDisabledCircleShadows({
    double offsetX = 4,
    double offsetY = 3,
    double alpha = 0.3,
  }) => [
    BoxShadow(
      color: Color.alphaBlend(
        Colors.black.withValues(alpha: alpha),
        AppColors.darkGrey,
      ),
      spreadRadius: 2,
      blurRadius: 0,
      offset: Offset(offsetX, offsetY),
    ),
  ];
}
