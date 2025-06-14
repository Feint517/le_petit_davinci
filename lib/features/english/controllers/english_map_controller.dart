import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnglishMapController extends GetxController {
  final GlobalKey svgKey = GlobalKey();

  final RxDouble _svgRenderedWidth = RxDouble(0.0);
  final RxDouble _svgRenderedHeight = RxDouble(0.0);

  double? get svgRenderedWidth =>
      _svgRenderedWidth.value == 0.0 ? null : _svgRenderedWidth.value;
  double? get svgRenderedHeight =>
      _svgRenderedHeight.value == 0.0 ? null : _svgRenderedHeight.value;

  void getSvgDimensions() {
    if (svgKey.currentContext != null) {
      final RenderBox renderBox =
          svgKey.currentContext!.findRenderObject() as RenderBox;
      _svgRenderedWidth.value = renderBox.size.width;
      _svgRenderedHeight.value = renderBox.size.height;
      if (kDebugMode) {
        print('SVG dimensions: ${renderBox.size}');
      }
    } else {
      if (kDebugMode) {
        print(
          'Controller: Warning: svgKey.currentContext is null. Could not get dimensions.',
        );
      }
    }
  }
}
