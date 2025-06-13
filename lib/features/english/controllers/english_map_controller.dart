import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnglishMapController extends GetxController {
  final GlobalKey svgKey = GlobalKey();

  // Make these observable so the UI rebuilds when they change
  final RxDouble _svgRenderedWidth = RxDouble(0.0);
  final RxDouble _svgRenderedHeight = RxDouble(0.0);

  // Expose them as getters (optional, but good practice)
  double? get svgRenderedWidth =>
      _svgRenderedWidth.value == 0.0 ? null : _svgRenderedWidth.value;
  double? get svgRenderedHeight =>
      _svgRenderedHeight.value == 0.0 ? null : _svgRenderedHeight.value;

  @override
  void onInit() {
    super.onInit();
    getSvgDimensions();
  }

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
      //? Retry after a short delay
      Future.delayed(const Duration(milliseconds: 50), getSvgDimensions);
    }
  }
}
