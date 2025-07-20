import 'package:flutter/material.dart';

class ColorsUtils {
  static Color makeDarker(Color color, [double factor = 0.2]) {
    final hslColor = HSLColor.fromColor(color);
    final darkenedHslColor = hslColor.withLightness(
      (hslColor.lightness - factor).clamp(0.0, 1.0),
    );
    return darkenedHslColor.toColor();
  }
}
