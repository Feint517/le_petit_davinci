import 'package:flutter/services.dart' show rootBundle;

class ImageUtils {
  static bool isSvg(String assetPath) {
    return assetPath.toLowerCase().endsWith('.svg');
  }

  static Future<double?> getSvgAspectRatio(String assetPath) async {
    final String svgString = await rootBundle.loadString(assetPath);
    final viewBoxMatch = RegExp(
      r'viewBox="([\d\.\s\-]+)"',
    ).firstMatch(svgString);
    if (viewBoxMatch != null) {
      final parts = viewBoxMatch.group(1)!.split(RegExp(r'\s+'));
      if (parts.length == 4) {
        final width = double.tryParse(parts[2]);
        final height = double.tryParse(parts[3]);
        if (width != null && height != null && width != 0) {
          return height / width;
        }
      }
    }
    return null;
  }
}
